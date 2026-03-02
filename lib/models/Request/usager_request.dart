class UsagerRequest {
  String? nom;
  String? prenom;
  String? email;
  String? telephone;
  String? dateNaissance;

  UsagerRequest({
    this.nom,
    this.prenom,
    this.email,
    this.telephone,
    this.dateNaissance,
  });

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
      'dateNaissance': dateNaissance,
    };
  }
  factory UsagerRequest.fromJson(Map<String, dynamic> json) {
    return UsagerRequest(
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      telephone: json['telephone'],
      dateNaissance: json['dateNaissance'],

    );
  }
}
