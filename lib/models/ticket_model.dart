
import 'evenement_model.dart';

class Ticket {
  final String id;
  final String event;
  final String type;
  final double price;
  final int quantity;
  final int sold;
  final DateTime createdAt;
  final EvenementModel? eventDetails;

  Ticket({
    required this.id,
    required this.event,
    required this.type,
    required this.price,
    required this.quantity,
    this.sold = 0,
    required this.createdAt,
    this.eventDetails,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['_id'] ?? json['id'] ?? '',
      event: json['event'] ?? '',
      type: json['type'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      sold: json['sold'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      eventDetails: json['event'] != null ? EvenementModel.fromJson(json['event']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'event': event,
      'type': type,
      'price': price,
      'quantity': quantity,
      'sold': sold,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Ticket copyWith({
    String? id,
    String? event,
    String? type,
    double? price,
    int? quantity,
    int? sold,
    DateTime? createdAt,
    EvenementModel? eventDetails,
  }) {
    return Ticket(
      id: id ?? this.id,
      event: event ?? this.event,
      type: type ?? this.type,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      sold: sold ?? this.sold,
      createdAt: createdAt ?? this.createdAt,
      eventDetails: eventDetails ?? this.eventDetails,
    );
  }

  int get available => quantity - sold;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Ticket && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Ticket{id: $id, event: $event, type: $type, price: $price, quantity: $quantity, sold: $sold, createdAt: $createdAt}';
  }
}
