class UserConnected {
  String? refUsager;
  String? nom;
  String? prenom;
  String? dateNaissance;
  String? email;
  String? telephone;
  String? terminalId;

  UserConnected({
    this.refUsager,
    this.nom,
    this.prenom,
    this.telephone,
    this.dateNaissance,
    this.email,
    this.terminalId,
  });

  UserConnected.fromJson(Map<String, dynamic> json) {
    refUsager = json['refUsager'];
    nom = json['nom'];
    prenom = json['prenom'];
    dateNaissance = json['dateNaissance'];
    email = json['email'];
    telephone = json['telephone'];
    terminalId = json['terminalId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refUsager'] = this.refUsager;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['dateNaissance'] = this.dateNaissance;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['terminalId'] = this.terminalId;
    return data;
  }
}
