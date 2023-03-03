class UserModel {
  String? firstName;
  String? email;
  String? lastName;
  String? profilePicture;
  String? phoneNumber;

  UserModel({
    this.firstName,
    this.email,
    this.lastName,
    this.profilePicture,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["firstName"] as String,
        email: json["email"] as String,
        lastName: json["lastName"] as String,
        profilePicture: json["profilePicture"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "email": email,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "phoneNumber": phoneNumber,
      };
}
