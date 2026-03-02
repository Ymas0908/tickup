class UpdatePasswordRequest {
  String login;
  String oldPassword;
  String newPassword;
  String confirmNewPassword;

  UpdatePasswordRequest({
    required this.login,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordRequest(
      login: json['login'],
      oldPassword: json['oldPassword'],
      newPassword: json['newPassword'],
      confirmNewPassword: json['confirmNewPassword'],
    );
  }
}
