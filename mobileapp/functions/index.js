const functions = require("firebase-functions");

exports.writeFeatures = functions.https.onCall(async (data, context) => {
  const datas = data.list;
  // Mean
  let sum = 0;
  let willisonAmplitude = 0;
  let myopulse = 0;
  let thresholdForWillisonAmplitude = 0.1;
  let thresholdForMyopulsePercentageRate = 2.5;
  let diffBetweenSignals = 0;
  const sumForMMAV1 = [];
  for (let i = 0; i < datas.length; i++) {
    sum += datas[i];
    let wN = 0;
    if (0.25 * datas.length <= i + 1 && i + 1 <= 0.75 * datas.length) {
      wN = 1;
    } else {
      wN = 0.5;
    }
    const value = wN * Math.abs(datas[i]);
    sumForMMAV1.push(value);
  }
  const mean = sum / datas.length;
  thresholdForMyopulsePercentageRate=mean;
  for (let i = 0; i < datas.length; i++) {
    if (datas[i] >= thresholdForMyopulsePercentageRate) {
      myopulse += 1;
    }
  }
  // Mean Absolute Deviation
  const differences = [];
  let difference = 0;

  for (let i = 0; i < datas.length; i++) {
    difference = mean - datas[i];
    if (difference < 0) {
      difference = -difference;
    }
    differences.push(difference);
  }
  // Variance
  let totalDifference = 0;
  for (let j = 0; j < differences.length; j++) {
    totalDifference += differences[j];
  }
  const meanAbsoluteDeviation = totalDifference / differences.length;
  let totalDifferenceSquare = 0;
  for (let j = 0; j < differences.length; j++) {
    totalDifferenceSquare += differences[j] * differences[j];
  }
  const variance = totalDifferenceSquare / (differences.length - 1);
  // Average Amplitude Change
  const differencesBetweenSignals = [];
  let differenceBetweenSignals = 0;
  for (let j = 1; j < datas.length; j++) {
    differenceBetweenSignals = datas[j] - datas[j - 1];
    if (differenceBetweenSignals < 0) {
      differenceBetweenSignals = -differenceBetweenSignals;
    }
    differencesBetweenSignals.push(differenceBetweenSignals);
  }
  let totalBetweenSignals = 0;
  for (let j = 0; j < differencesBetweenSignals.length; j++) {
    totalBetweenSignals += differencesBetweenSignals[j];
  }
  const averageAmplitudeChange =
    totalBetweenSignals / differencesBetweenSignals.length;
  thresholdForWillisonAmplitude = averageAmplitudeChange;
  for (let j = 1; j < datas.length; j++) {
    diffBetweenSignals = datas[j] - datas[j - 1];
    if (diffBetweenSignals >= thresholdForWillisonAmplitude ||
      diffBetweenSignals <= -thresholdForWillisonAmplitude) {
      willisonAmplitude += 1;
    }
  }
  // Root Mean Square
  let totalSquares = 0;
  for (let j = 0; j < datas.length; j++) {
    totalSquares += datas[j] * datas[j];
  }
  const rootMeanSquare = Math.sqrt(totalSquares / datas.length);
  const simpleSquareIntegrals = totalDifferenceSquare;
  const IntegratedEMG = sum;
  const waveFormLength = totalBetweenSignals;
  const willisonAmplitudePercentage = willisonAmplitude / (datas.length - 1);

  const logs = [];
  for (let j = 0; j < datas.length; j++) {
    const log = Math.log10(Math.abs(datas[j]));
    logs.push(log);
  }
  let totalLogs = 0;
  for (let j = 0; j < logs.length; j++) {
    totalLogs += logs[j];
  }
  const logDetector = Math.exp(totalLogs / logs.length);

  let tDF = 0;
  for (let j = 0; j < differencesBetweenSignals.length; j++) {
    tDF += differencesBetweenSignals[j] * differencesBetweenSignals[j];
  }
  const dASDV = Math.sqrt(tDF / (differencesBetweenSignals.length - 1));
  const myopulsePercentageRate = myopulse / datas.length;

  let totalForMMAV1 = 0;
  for (let j = 0; j < sumForMMAV1.length; j++) {
    totalForMMAV1 += sumForMMAV1[j];
  }
  const modifiedMeanAbsoluteValue1 = totalForMMAV1 / datas.length;

  const featurestList = [
    mean,
    meanAbsoluteDeviation,
    variance,
    averageAmplitudeChange,
    rootMeanSquare,
    simpleSquareIntegrals,
    IntegratedEMG,
    waveFormLength,
    willisonAmplitudePercentage,
    logDetector,
    dASDV,
    myopulsePercentageRate,
    modifiedMeanAbsoluteValue1,
  ];
  return featurestList;
});
