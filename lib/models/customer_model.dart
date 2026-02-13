import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String? id; // ID Firebase
  String? name;
  String? email;
  String? phone;
  DateTime? createdAt;
  DateTime? lastLogin;

  Customer({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.createdAt,
    this.lastLogin,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
      createdAt: json['createdAt'],
      lastLogin: json['lastLogin'],


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'email': email,
      'createdAt': createdAt,
      'lastLogin': lastLogin,

    };
  }


}