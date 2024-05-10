class LoginRequest {
  String emailOrPhoneNo;
  String? password;
  String? deviceSerialNumber;
  String? deviceOSName;
  LoginRequest({required this.emailOrPhoneNo, required this.password});
}

class LoginResponse {
  int? code;
  String? message;
  String? version;
  LoginDetails? details;

  LoginResponse(
      {this.code, this.message, this.version, this.details});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    version = json['version'];
    details =
    json['details'] != null ? LoginDetails.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['version'] = version;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class LoginDetails {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;
  String? error;
  int? userID;

  LoginDetails(
      {this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.refreshToken,
        this.error,
        this.userID});

  LoginDetails.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
    expiresIn = json['expiresIn'];
    refreshToken = json['refreshToken'];
    error = json['error'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['tokenType'] = tokenType;
    data['expiresIn'] = expiresIn;
    data['refreshToken'] = refreshToken;
    data['error'] = error;
    data['userID'] = userID;
    return data;
  }
}
