import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mobileapp/screens/Training/training_four.dart';

class TrainingThree extends StatefulWidget {
  static const routeName = '/TrainingThree';

  final BluetoothDevice server;
  final String muscle;
  final String muscleImage;
  final String exerciseName;
  final double weight;
  final int setNumber;
  final int statusOfUser;

  const TrainingThree({
    required this.server,
    required this.muscle,
    required this.muscleImage,
    required this.exerciseName,
    required this.weight,
    required this.setNumber,
    required this.statusOfUser,
  });

  @override
  State<TrainingThree> createState() => _TrainingThreeState();
}

class _TrainingThreeState extends State<TrainingThree> {
  Duration duration = Duration();
  Timer? timer;

  static final clientID = 0;
  BluetoothConnection? connection;
  String _messageBuffer = '';

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;
  bool isStart = false;
  final growableList = <double>[];

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
    _sendMessage('b');
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Training...'),
        ),
        body: isConnected
            ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.10,
                    ),
                    Text(
                      isStart ? 'Keep continue...' : 'Lets Start..',
                      textScaleFactor: 2,
                    ),
                    SizedBox(
                      height: height * 0.10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black38)),
                          child: Text(
                            '${minutes}',
                            style:
                                TextStyle(fontSize: 100, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black38)),
                          child: Text(
                            '${seconds}',
                            style:
                                TextStyle(fontSize: 100, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                width * 0.3,
                                height * 0.06,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _sendMessage('a');
                                _sendMessage('b');
                                timer = Timer.periodic(Duration(seconds: 1),
                                    (timer) {
                                  setState(() {
                                    isStart = true;
                                    final seconds = duration.inSeconds + 1;
                                    duration = Duration(seconds: seconds);
                                  });
                                });
                              });
                            },
                            child: Text(
                              'Start',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.015,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                width * 0.3,
                                height * 0.06,
                              ),
                            ),
                            onPressed: () {
                              _sendMessage('c');
                              _sendMessage('c');
                              _sendMessage('c');
                              _sendMessage('a');
                              setState(() {
                                timer?.cancel();
                              });

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TraningFinish(
                                      server: widget.server,
                                      exerciseName: widget.exerciseName,
                                      muscle: widget.muscle,
                                      muscleImage: widget.muscleImage,
                                      weight: double.parse(
                                          widget.weight.toString()),
                                      setNumber: int.parse(
                                          widget.setNumber.toString()),
                                      statusOfUser: int.parse(
                                        widget.statusOfUser.toString(),
                                      ),
                                      datas: growableList,
                                      duration: duration.inSeconds,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Stop',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Device will be ready a few seconds..')
                    ],
                  ),
                ),
              ));
  }

  void onDataReceived(Uint8List data) {
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }
    String dataString = String.fromCharCodes(buffer);

    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        growableList.add(
          double.parse(
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;
      } catch (e) {
        setState(() {});
      }
    }
  }
}
