class UserInformations {
  final String id;
  final String? name;
  final String? surname;
  final String email;
  final String? gender;
  final DateTime registerDate;
  final DateTime? dateofBirth;
  final String? alcohol;
  final String? tobocco;

  UserInformations({
    required this.id,
    this.name,
    this.surname,
    required this.email,
    this.gender,
    required this.registerDate,
    this.dateofBirth,
    this.alcohol,
    this.tobocco,
  });

  UserInformations.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          surname: json['surname']! as String,
          email: json['email']! as String,
          gender: json['gender']! as String,
          registerDate: json['registerDate']! as DateTime,
          dateofBirth: json['dateofBirth']! as DateTime,
          alcohol: json['alcohol']! as String,
          tobocco: json['tobocco']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'gender': gender,
      'registerDate': registerDate,
      'dateofBirth': dateofBirth,
      'alcohol': alcohol,
      'tobocco': tobocco,
    };
  }
}
