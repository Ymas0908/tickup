class Venue {
  final String id;
  final String name;
  final String address;
  final String city;
  final String country;
  final int? capacity;
  final DateTime createdAt;

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.country,
    this.capacity,
    required this.createdAt,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      capacity: json['capacity'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'address': address,
      'city': city,
      'country': country,
      if (capacity != null) 'capacity': capacity,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Venue copyWith({
    String? id,
    String? name,
    String? address,
    String? city,
    String? country,
    int? capacity,
    DateTime? createdAt,
  }) {
    return Venue(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      capacity: capacity ?? this.capacity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get fullAddress => '$address, $city, $country';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Venue && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Venue{id: $id, name: $name, address: $address, city: $city, country: $country, capacity: $capacity, createdAt: $createdAt}';
  }
}
