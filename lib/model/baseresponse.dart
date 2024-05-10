import 'customer.dart';

class BaseResponse {
  int? code;
  String? message;
  String? errorMessage;
  BaseResponse(
      {this.code, this.message, this.errorMessage});
  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['errorMessage'] = errorMessage;
    return data;
  }

}

class CustomerBaseResponse {
  int? code;
  String? message;
  String? errorMessage;
  List<CustomerDeviceDetail>? data;
  int? total;
  CustomerBaseResponse(
      {this.code, this.message, this.errorMessage, this.data});
  CustomerBaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    errorMessage = json['errorMessage'];
    data = json['data'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['errorMessage'] = errorMessage;
    data['data'] = data;
    data['total'] = total;
    return data;
  }

}

class CustomerDeviceSearchResponse {
  int? code;
  String? message;
  String? version;
  CustomerDeviceDetail? details;
  String? errorMessage;

  CustomerDeviceSearchResponse(
      {this.code, this.message, this.version, this.details, this.errorMessage});

  CustomerDeviceSearchResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    version = json['version'];
    details =
    json['details'] != null ? new CustomerDeviceDetail.fromJson(json['details']) : null;
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['version'] = this.version;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}
//////////////////////////////////////////////////
class DashboardBaseResponse {
  int? code;
  String? message;
  String? version;
  DashboardDetails? details;
  String? errorMessage;

  DashboardBaseResponse(
      {this.code, this.message, this.version, this.details, this.errorMessage});

  DashboardBaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    version = json['version'];
    details =
    json['details'] != null ? new DashboardDetails.fromJson(json['details']) : null;
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['version'] = this.version;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

class DashboardDetails {
  int? totalDeviceActive;
  int? totalDeviceUploadToday;

  DashboardDetails({this.totalDeviceActive, this.totalDeviceUploadToday});

  DashboardDetails.fromJson(Map<String, dynamic> json) {
    totalDeviceActive = json['totalDeviceActive'];
    totalDeviceUploadToday = json['totalDeviceUploadToday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalDeviceActive'] = this.totalDeviceActive;
    data['totalDeviceUploadToday'] = this.totalDeviceUploadToday;
    return data;
  }
}

///////////////// đổi mật khẩu
class ChangePasswordResponse {
  int? code;
  String? message;
  String? version;
  String? errorMessage;

  ChangePasswordResponse(
      {this.code, this.message, this.version, this.errorMessage});

  ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    version = json['version'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['version'] = this.version;
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

//////////thông tin thông báo telegram
class CustomerSettingResponse {
  int? code;
  String? message;
  String? version;
  CustomerSettingDetails? details;
  String? errorMessage;

  CustomerSettingResponse(
      {this.code, this.message, this.version, this.details, this.errorMessage});

  CustomerSettingResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    version = json['version'];
    details =
    json['details'] != null ? new CustomerSettingDetails.fromJson(json['details']) : null;
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['version'] = this.version;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

class CustomerSettingDetails {
  String? contactText;
  String? updatedOn;

  CustomerSettingDetails({this.contactText, this.updatedOn});

  CustomerSettingDetails.fromJson(Map<String, dynamic> json) {
    contactText = json['contactText'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactText'] = this.contactText;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}

///////////////update customer setting cho thông tin telegram
class UpdateCustomerSettingResponse {
  int? code;
  String? message;
  String? version;
  int? details;
  String? errorMessage;

  UpdateCustomerSettingResponse(
      {this.code, this.message, this.version, this.details, this.errorMessage});

  UpdateCustomerSettingResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    version = json['version'];
    details = json['details'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['version'] = this.version;
    data['details'] = this.details;
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

class UploadFileResponse {
  int? code;
  String? message;
  String? version;
  UploadFileDetails? details;
  String? errorMessage;

  UploadFileResponse(
      {this.code, this.message, this.version, this.details, this.errorMessage});

  UploadFileResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    version = json['version'];
    details =
    json['details'] != null ? new UploadFileDetails.fromJson(json['details']) : null;
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['version'] = this.version;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

class UploadFileDetails {
  int? status;
  String? description;

  UploadFileDetails({this.status, this.description});

  UploadFileDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['description'] = this.description;
    return data;
  }
}