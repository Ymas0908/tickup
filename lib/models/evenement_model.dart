class EvenementModel {
  String? sId;
  String? title;
  String? description;
  String? date;
  Venue? venue;
  Category? category;
  Organizer? organizer;
  List<Tickets>? tickets;
  bool? isApproved;
  String? imageUrl;
  int? iV;

  EvenementModel(
      {this.sId,
        this.title,
        this.description,
        this.date,
        this.venue,
        this.category,
        this.organizer,
        this.tickets,
        this.isApproved,
        this.imageUrl,
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
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(new Tickets.fromJson(v));
      });
    }
    isApproved = json['isApproved'];
    imageUrl = json['imageUrl'];
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
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    }
    data['isApproved'] = this.isApproved;
    data['imageUrl'] = this.imageUrl;
    data['__v'] = this.iV;
    return data;
  }
}

class Venue {
  String? sId;
  String? name;
  String? address;

  Venue({this.sId, this.name, this.address});

  Venue.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

class Category {
  String? sId;
  String? name;

  Category({this.sId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Organizer {
  String? sId;
  String? name;
  String? email;

  Organizer({this.sId, this.name, this.email});

  Organizer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class Tickets {
  String? sId;
  String? event;
  String? type;
  int? price;
  int? quantity;
  int? sold;
  String? createdAt;
  int? iV;

  Tickets(
      {this.sId,
        this.event,
        this.type,
        this.price,
        this.quantity,
        this.sold,
        this.createdAt,
        this.iV});

  Tickets.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    event = json['event'];
    type = json['type'];
    price = json['price'];
    quantity = json['quantity'];
    sold = json['sold'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['event'] = this.event;
    data['type'] = this.type;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['sold'] = this.sold;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}