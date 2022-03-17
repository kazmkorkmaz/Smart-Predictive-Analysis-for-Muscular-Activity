class UserInformations {
  final String id;
  final String? name;
  final String? surname;
  final String email;
  final String? gender;
  final String registerDate;
  final String? dateofBirth;
  final String? alcohol;
  final String? tobocco;
  final String? age;
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
    this.age,
  });

  UserInformations.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          surname: json['surname']! as String,
          email: json['email']! as String,
          gender: json['gender']! as String,
          registerDate: json['registerDate']! as String,
          dateofBirth: json['dateofBirth']! as String,
          alcohol: json['alcohol']! as String,
          tobocco: json['tobocco']! as String,
          age: json['age']! as String,
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
      'age': age,
    };
  }
}
