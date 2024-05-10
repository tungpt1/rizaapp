class CustomerResponse {
  int? code;
  String? message;
  String? version;
  Details? details;
  String? errorMessage;

  CustomerResponse(
      {this.code, this.message, this.version, this.details, this.errorMessage});

  CustomerResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    version = json['version'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
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

class Details {
  bool? hasMore;
  int? total;
  List<CustomerDeviceDetail>? data;

  Details({this.hasMore, this.total, this.data});

  Details.fromJson(Map<String, dynamic> json) {
    hasMore = json['hasMore'];
    total = json['total'];
    if (json['data'] != null) {
      data = <CustomerDeviceDetail>[];
      json['data'].forEach((v) {
        data!.add(new CustomerDeviceDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasMore'] = this.hasMore;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerDeviceDetail {
  int? id;
  int? userID;
  String? deviceName;
  int? deviceCategoryID;
  String? deviceCategoryName;
  String? deviceSerialNum;
  int? status;
  int? companyID;
  String? companyName;
  String? roomNo;
  int? level;
  String? zone;
  String? area;
  String? cityName;
  String? countryCode;
  String? createdOn;
  String? updatedOn;
  String? description;
  String? qrCode;
  String? deviceGuid;
  int? brandID;
  String? brandName;

  CustomerDeviceDetail(
      {this.id,
        this.userID,
        this.deviceName,
        this.deviceCategoryID,
        this.deviceCategoryName,
        this.deviceSerialNum,
        this.status,
        this.companyID,
        this.companyName,
        this.roomNo,
        this.level,
        this.zone,
        this.area,
        this.cityName,
        this.countryCode,
        this.createdOn,
        this.updatedOn,
        this.description,
        this.qrCode,
        this.deviceGuid,
        this.brandID,
        this.brandName});

  CustomerDeviceDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    deviceName = json['deviceName'];
    deviceCategoryID = json['deviceCategoryID'];
    deviceCategoryName = json['deviceCategoryName'];
    deviceSerialNum = json['deviceSerialNum'];
    status = json['status'];
    companyID = json['companyID'];
    companyName = json['companyName'];
    roomNo = json['roomNo'];
    level = json['level'];
    zone = json['zone'];
    area = json['area'];
    cityName = json['cityName'];
    countryCode = json['countryCode'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    description = json['description'];
    qrCode = json['qrCode'];
    deviceGuid = json['deviceGuid'];
    brandID = json['brandID'];
    brandName = json['brandName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['deviceName'] = this.deviceName;
    data['deviceCategoryID'] = this.deviceCategoryID;
    data['deviceCategoryName'] = this.deviceCategoryName;
    data['deviceSerialNum'] = this.deviceSerialNum;
    data['status'] = this.status;
    data['companyID'] = this.companyID;
    data['companyName'] = this.companyName;
    data['roomNo'] = this.roomNo;
    data['level'] = this.level;
    data['zone'] = this.zone;
    data['area'] = this.area;
    data['cityName'] = this.cityName;
    data['countryCode'] = this.countryCode;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['description'] = this.description;
    data['qrCode'] = this.qrCode;
    data['deviceGuid'] = this.deviceGuid;
    data['brandID'] = this.brandID;
    data['brandName'] = this.brandName;
    return data;
  }
}
