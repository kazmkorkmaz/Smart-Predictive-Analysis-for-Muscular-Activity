class BodyMeasurementsInfo {
  final double? height;
  final double? weight;
  final double? arm;
  final double? chest;
  final double? shoulder;
  final double? waist;
  final double? hipst;
  final double? thigh;
  final DateTime? createdAt;

  BodyMeasurementsInfo({
    this.height,
    this.weight,
    this.arm,
    this.chest,
    this.shoulder,
    this.waist,
    this.hipst,
    this.thigh,
    this.createdAt,
  });

  BodyMeasurementsInfo.fromJson(Map<String, Object?> json)
      : this(
          height: json['height']! as double,
          weight: json['weight']! as double,
          arm: json['arm']! as double,
          chest: json['chest']! as double,
          shoulder: json['shoulder']! as double,
          waist: json['waist']! as double,
          hipst: json['hipst']! as double,
          thigh: json['thigh']! as double,
          createdAt: json['createdAt']! as DateTime,
        );

  Map<String, Object?> toJson() {
    return {
      'height': height,
      'weight': weight,
      'arm': arm,
      'chest': chest,
      'shoulder': shoulder,
      'waist': waist,
      'hipst': hipst,
      'thigh': thigh,
      'createdAt': createdAt,
    };
  }

  BodyMeasurementsInfo.fromMap(Map<String, dynamic> map)
      : assert(map['height'] != null),
        assert(map['weight'] != null),
        assert(map['arm'] != null),
        assert(map['chest'] != null),
        assert(map['shoulder'] != null),
        assert(map['waist'] != null),
        assert(map['hipst'] != null),
        assert(map['thigh'] != null),
        assert(map['createdAt'] != null),
        height = map['height'],
        weight = map['weight'],
        arm = map['arm'],
        chest = map['chest'],
        shoulder = map['shoulder'],
        waist = map['waist'],
        hipst = map['hipst'],
        thigh = map['thigh'],
        createdAt = DateTime.parse(map['createdAt'].toDate().toString());
}
