class UpdateUserPasswordForgetRequest {
  String? login;
  String? newPassword;
  String? confirmNewPassword;

  UpdateUserPasswordForgetRequest({
    this.login,
    this.newPassword,
    this.confirmNewPassword,
  });

  factory UpdateUserPasswordForgetRequest.fromJson(Map<String, dynamic> json) {
    return UpdateUserPasswordForgetRequest(
      login: json['login'],
      newPassword: json['newPassword'],
      confirmNewPassword: json['confirmNewPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }
}