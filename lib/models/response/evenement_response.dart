class EvenementResponse {
  int? id;
  String? nom;
  String? reference;
  String? urlImage;
  String? libelle;
  String? description;
  String? lieu;
  String? prixTicketGP;
  String? prixTicketVIP;
  String? prixTicketVVIP;
  String? dateHeureEvenement;
  DateTime? dateHeureCreation;
  String? typeEvenement;

  EvenementResponse(
      {this.id,
        this.nom,
        this.reference,
        this.urlImage,
        this.libelle,
        this.description,
        this.lieu,
        this.prixTicketGP,
        this.prixTicketVIP,
        this.prixTicketVVIP,
        this.dateHeureEvenement,
        this.dateHeureCreation,
        this.typeEvenement});

  EvenementResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    reference = json['reference'];
    urlImage = json['urlImage'];
    libelle = json['libelle'];
    description = json['description'];
    lieu = json['lieu'];
    prixTicketGP = json['prixTicketGP'];
    prixTicketVIP = json['prixTicketVIP'];
    prixTicketVVIP = json['prixTicketVVIP'];
    dateHeureEvenement = json['dateHeureEvenement'];
    dateHeureCreation = json['dateHeureCreation'];
    typeEvenement = json['typeEvenement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['reference'] = this.reference;
    data['urlImage'] = this.urlImage;
    data['libelle'] = this.libelle;
    data['description'] = this.description;
    data['lieu'] = this.lieu;
    data['prixTicketGP'] = this.prixTicketGP;
    data['prixTicketVIP'] = this.prixTicketVIP;
    data['prixTicketVVIP'] = this.prixTicketVVIP;
    data['dateHeureEvenement'] = this.dateHeureEvenement;
    data['dateHeureCreation'] = this.dateHeureCreation;
    data['typeEvenement'] = this.typeEvenement;
    return data;
  }
}