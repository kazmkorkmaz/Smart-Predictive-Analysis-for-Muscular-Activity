class BodyMeasurementsInfo {
  final double? height;
  final double? weight;
  final double? arm;
  final double? chest;
  final double? shoulder;
  final double? waist;
  final double? hipst;
  final double? thigh;
  BodyMeasurementsInfo({
    this.height,
    this.weight,
    this.arm,
    this.chest,
    this.shoulder,
    this.waist,
    this.hipst,
    this.thigh,
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
    };
  }
}
