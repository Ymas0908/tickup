class AuthData {
  String? accessToken;
  String? refreshToken;
  int? expiresIn;
  String? refUsager;
  bool? isFisrtConnection;

  AuthData(
      {this.accessToken,
        this.refreshToken,
        this.expiresIn,
        this.refUsager,
        this.isFisrtConnection});

  AuthData.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    expiresIn = json['expiresIn'];
    refUsager = json['refUsager'];
    isFisrtConnection = json['isFisrtConnection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['expiresIn'] = this.expiresIn;
    data['refUsager'] = this.refUsager;
    data['isFisrtConnection'] = this.isFisrtConnection;
    return data;
  }
}