class PaiementProResponse {
  final bool success;
  final String? url;
  final String? message;

  PaiementProResponse({
    required this.success,
    this.url,
    this.message,
  });

  factory PaiementProResponse.fromJson(Map<String, dynamic> json) {
    return PaiementProResponse(
      success: json['success'] ?? false,
      url: json['url'],
      message: json['message'],
    );
  }
}
