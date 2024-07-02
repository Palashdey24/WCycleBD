class Users {
  Users({
    required this.phoneNumber,
    required this.gender,
    required this.imgUri,
    required this.userName,
    required this.birthDate,
    required this.email,
  });
  late final String phoneNumber;
  late final String gender;
  late final String imgUri;
  late final String userName;
  late final String birthDate;
  late final String email;

  Users.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    imgUri = json['img_uri'];
    userName = json['userName'];
    birthDate = json['birthDate'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phoneNumber'] = phoneNumber;
    _data['gender'] = gender;
    _data['img_uri'] = imgUri;
    _data['userName'] = userName;
    _data['birthDate'] = birthDate;
    _data['email'] = email;
    return _data;
  }
}
