class EvenementModel {
  String? sId;
  String? title;
  String? description;
  String? date;
  Venue? venue;
  Category? category;
  Organizer? organizer;
  bool? isApproved;
  int? iV;

  EvenementModel(
      {this.sId,
        this.title,
        this.description,
        this.date,
        this.venue,
        this.category,
        this.organizer,
        this.isApproved,
        this.iV});

  EvenementModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    organizer = json['organizer'] != null
        ? new Organizer.fromJson(json['organizer'])
        : null;
    isApproved = json['isApproved'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.organizer != null) {
      data['organizer'] = this.organizer!.toJson();
    }
    data['isApproved'] = this.isApproved;
    data['__v'] = this.iV;
    return data;
  }
}

class Venue {
  String? sId;
  String? name;
  String? address;
  String? city;
  String? country;
  int? capacity;
  String? createdAt;
  int? iV;

  Venue(
      {this.sId,
        this.name,
        this.address,
        this.city,
        this.country,
        this.capacity,
        this.createdAt,
        this.iV});

  Venue.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    capacity = json['capacity'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['capacity'] = this.capacity;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Category {
  String? sId;
  String? name;
  String? description;
  String? createdAt;
  int? iV;

  Category({this.sId, this.name, this.description, this.createdAt, this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Organizer {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? role;
  String? createdAt;
  int? iV;

  Organizer(
      {this.sId,
        this.name,
        this.email,
        this.password,
        this.role,
        this.createdAt,
        this.iV});

  Organizer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}