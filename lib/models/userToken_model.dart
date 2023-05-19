class RequestToken {
  bool? success;
  String? expiresAt;
  String? requestToken;

  RequestToken({
     this.success,
     this.expiresAt,
     this.requestToken,
  });

  factory RequestToken.fromJson(Map<String, dynamic> json) => RequestToken(
    success: json["success"]??null,
    expiresAt: json["expires_at"]??null,
    requestToken: json["request_token"]??null,
  );

  Map<String, dynamic> toJson() => {
    "request_token": requestToken,
  };
}