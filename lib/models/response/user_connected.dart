class UserResponse {
  late final String? refUser;
  late final String? nom;
  late final String? prenom;
  late final String? address1;
  final String? pays;
  late final String? contactPersonMobile;
  late final String? email;


  UserResponse(
      {
        this.refUser,
        this.nom,
        this.prenom,
        this.address1,
        this.pays,
        this.contactPersonMobile,
        this.email,
     });

  UserResponse.fromJson(Map<String, dynamic> json, {this.refUser, this.nom, this.prenom, this.address1, this.pays, this.contactPersonMobile, this.email}) {
    refUser = json['refUser'];
    nom = json['nom'];
    prenom = json['prenom'];
    address1 = json['address1'];
    contactPersonMobile = json['contactPersonMobile'];
    email = json['email'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refUser'] = this.refUser;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['address1'] = this.address1;
    data['contactPersonMobile'] = this.contactPersonMobile;
    data['email'] = this.email;

    return data;
  }
}