class Users {
  Users(
      {required this.phoneNumber,
      required this.gender,
      required this.imgUri,
      required this.userName,
      required this.birthDate,
      required this.email,
      this.doc,
      this.userId,
      required this.individual,
      required this.userStatus});
  late final String phoneNumber;
  late final String gender;
  late final String imgUri;
  late final String userName;
  late final String birthDate;
  late final String email;
  late final String? doc;
  late final bool? individual;
  late final String? userStatus;
  String? userId;

  Users.fromJson(Map<String, dynamic> json, {this.userId}) {
    phoneNumber = json['phoneNumber'] ?? "N?A";
    gender = json['gender'];
    imgUri = json['img_uri'];
    userName = json['userName'];
    birthDate = json['birthDate'];
    email = json['email'];
    doc = json['doc'];
    individual = json['individual'] ?? true;
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;
    data['img_uri'] = imgUri;
    data['userName'] = userName;
    data['birthDate'] = birthDate;
    data['email'] = email;
    data['doc'] = doc;
    data['individual'] = individual;
    data['userStatus'] = userStatus;
    return data;
  }
}
