
import 'package:flutter/foundation.dart';

class ResponseError {
  String? message;
  String? status;
  String? body;
  String? timestamp;
  Map<String, dynamic>? errors;

  ResponseError({
    this.message,
    this.status,
    this.body,
    this.timestamp,
    this.errors,
  });

  ResponseError copyWith({
    String? message,
    String? status,
    String? body,
    String? timestamp,
    Map<String, dynamic>? errors,
  }) {
    return ResponseError(
      message: message ?? this.message,
      status: status ?? this.status,
      body: body ?? this.body,
      timestamp: timestamp ?? this.timestamp,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'body': body,
      'timestamp': timestamp,
      'errors': errors ?? {},
    };
  }

  factory ResponseError.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print("ResponseError json: $json");
    }
    return ResponseError(
      message: json['message']?.toString(),
      status: json['status']?.toString(),
      body: json['body']?.toString(),
      timestamp: json['timestamp']?.toString(),
      errors: (json['errors'] as Map?)?.cast<String, dynamic>(),
    );
  }


  @override
  String toString() =>
      "ResponseError(message: $message,status: $status,body: $body,timestamp: $timestamp ,errors: $errors)";

  @override
  int get hashCode => Object.hash(message, status, body, timestamp);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseError &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          status == other.status &&
          body == other.body &&
          errors == other.errors &&
          timestamp == other.timestamp;
}
