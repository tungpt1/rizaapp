import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../model/baseresponse.dart';
import '../model/customer.dart';
import '/config/constant.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LdDragonApiManController {
  late Dio _dio;
  LdDragonApiManController() {
    _dio = Dio(BaseOptions(
      baseUrl: CUSTOMER_DEVICE_LIST_API,
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }
   final storage = const FlutterSecureStorage();

  //list customer device
  Future<CustomerBaseResponse> customerDeviceList(int pageNumber,String? deviceSearchInfo,String? customerName,int? status , DateTime? fromDate, DateTime? toDate) async {
    try {
      //var deviceSerialNumberHash = await storage.read(key: 'deviceSerialNumberHash');
      var accessToken = await storage.read(key: 'accessToken');
      var userID = await storage.read(key: 'userID');
      var outputFormat = DateFormat('yyyy-MM-dd');
      Response response = await _dio.post(CUSTOMER_DEVICE_LIST_API,
        options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $accessToken'
            }
        ),
        data: jsonEncode({
          "pageSize": 10,
          "pageNumber": pageNumber,
          "orderBy": "",
          "orderByColName": "",
          "userID": userID,
          "deviceSearchInfo": deviceSearchInfo,
          "customerName": customerName,
          "status": status.toString(),
          "fromDate": outputFormat.format(fromDate!),
          "toDate": outputFormat.format(toDate!),
        }),
      );
      CustomerResponse dataUser = CustomerResponse.fromJson(response.data);
      CustomerBaseResponse baseResponse = CustomerBaseResponse();
      baseResponse.code = dataUser.code;
      baseResponse.errorMessage = dataUser.message;
      if(dataUser.code == 0)
      {
        //print("============================== total record${dataUser.details?.total}");
        baseResponse.data = dataUser.details?.data!;
        baseResponse.total = dataUser.details?.total!;
        return baseResponse;
      }
      else
      {
        return baseResponse;
      }
    } on DioException catch (e) {
      CustomerBaseResponse baseResponse = CustomerBaseResponse();
      if ( e.response!.statusCode == 401 || e.response!.statusCode ==  403) {
        // Handle unauthorized error (e.g., navigate to login screen)
        baseResponse.code = SYSTEM_NOT_AUTHORIZE;
        baseResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_AUTHORIZE);
        baseResponse.message = CommonUtils.ErrorMessage(SYSTEM_NOT_AUTHORIZE);
      }
      else
        {
        // Handle other DioError types
          baseResponse.code = SYSTEM_NOT_OK;
          baseResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);
          baseResponse.message = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);
      }
      return baseResponse;
    }
  }



  Future<DashboardBaseResponse> dashboard() async{
    try {
      var deviceSerialNumber = await storage.read(key: 'deviceSerialNumber');
      var deviceOSName = await storage.read(key: 'deviceOSName');
      var accessToken = await storage.read(key: 'accessToken');
      var userID = await storage.read(key: 'userID');
      var emailOrPhoneNo = await storage.read(key: 'emailOrPhoneNo');

      Response response = await _dio.post(CUSTOMER_DASHBOARD_INFO_API,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Authorization": "Bearer $accessToken",
        }),
        data: jsonEncode({
          "userID": userID,
        }),
      );
      //print(response.data);
      DashboardBaseResponse dashboardBaseResponse = DashboardBaseResponse.fromJson(response.data);
      return dashboardBaseResponse;
    } on DioException catch (e) {
      //returns the error object if there is
      DashboardBaseResponse dashboardBaseResponse = DashboardBaseResponse();
      //print("============= ${e.response!.statusCode}");
      if ( e.response!.statusCode == 401 || e.response!.statusCode ==  403) {
        // Handle unauthorized error (e.g., navigate to login screen)
        dashboardBaseResponse.code = SYSTEM_NOT_AUTHORIZE;
        dashboardBaseResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_AUTHORIZE);
        dashboardBaseResponse.message = CommonUtils.ErrorMessage(SYSTEM_NOT_AUTHORIZE);

      } else {
        // Handle other DioError types
        dashboardBaseResponse.code = SYSTEM_NOT_OK;
        dashboardBaseResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);
        dashboardBaseResponse.message = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);

      }

      return dashboardBaseResponse;
    }
  }

  Future<DashboardBaseResponse> userValid() async{
    try {
      var deviceSerialNumber = await storage.read(key: 'deviceSerialNumber');
      var deviceOSName = await storage.read(key: 'deviceOSName');
      var accessToken = await storage.read(key: 'accessToken');
      var userID = await storage.read(key: 'userID');
      var emailOrPhoneNo = await storage.read(key: 'emailOrPhoneNo');

      Response response = await _dio.post(CUSTOMER_DASHBOARD_INFO_API,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Authorization": "Bearer $accessToken",
        }),
        data: jsonEncode({
          "userID": userID,
        }),
      );
      //print(response.data);
      DashboardBaseResponse dashboardBaseResponse = DashboardBaseResponse.fromJson(response.data);
      return dashboardBaseResponse;
    } on DioException catch (e) {
      //returns the error object if there is
      DashboardBaseResponse dashboardBaseResponse = DashboardBaseResponse();
      //print("============= ${e.response!.statusCode}");
      if ( e.response!.statusCode == 401 || e.response!.statusCode ==  403) {
        // Handle unauthorized error (e.g., navigate to login screen)
        dashboardBaseResponse.code = SYSTEM_NOT_AUTHORIZE;
        dashboardBaseResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_AUTHORIZE);
        dashboardBaseResponse.message = CommonUtils.ErrorMessage(SYSTEM_NOT_AUTHORIZE);

      } else {
        // Handle other DioError types
        dashboardBaseResponse.code = SYSTEM_NOT_OK;
        dashboardBaseResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);
        dashboardBaseResponse.message = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);

      }

      return dashboardBaseResponse;
    }
  }

  Future<ChangePasswordResponse> changePassword(String oldPassword, String newPassword) async{
    try {
      var deviceSerialNumber = await storage.read(key: 'deviceSerialNumber');
      var deviceOSName = await storage.read(key: 'deviceOSName');
      var accessToken = await storage.read(key: 'accessToken');
      var userID = await storage.read(key: 'userID');
      var emailOrPhoneNo = await storage.read(key: 'emailOrPhoneNo');

      Response response = await _dio.post(CUSTOMER_CHANGE_USER_PASS_API,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Authorization": "Bearer $accessToken",
        }),
        data: jsonEncode({
          "userID": userID,
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        }),
      );
      //print(response.data);
      ChangePasswordResponse changePasswordResponse = ChangePasswordResponse.fromJson(response.data);
      return changePasswordResponse;
    } on DioException catch (e) {
      //returns the error object if there is
      ChangePasswordResponse changePasswordResponse = ChangePasswordResponse();
      //print("============= ${e.response!.statusCode}");
      if ( e.response!.statusCode == 401 || e.response!.statusCode ==  403) {
        // Handle unauthorized error (e.g., navigate to login screen)
        changePasswordResponse.code = SYSTEM_NOT_AUTHORIZE;
        changePasswordResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_AUTHORIZE);
        changePasswordResponse.message = CommonUtils.ErrorMessage(SYSTEM_NOT_AUTHORIZE);

      } else {
        // Handle other DioError types
        changePasswordResponse.code = SYSTEM_NOT_OK;
        changePasswordResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);
        changePasswordResponse.message = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);

      }

      return changePasswordResponse;
    }
  }

  Future<UploadFileResponse> uploadDeviceFile(XFile? photo,
      String deviceSerialNumber,
      String deviceID,
      String deviceGuid,
      ) async{
    try {
      var deviceOSName = await storage.read(key: 'deviceOSName');
      var accessToken = await storage.read(key: 'accessToken');
      var userID = await storage.read(key: 'userID');
      var emailOrPhoneNo = await storage.read(key: 'emailOrPhoneNo');
      //print("====================${photo?.path?.toString()}");
      var data = FormData.fromMap({
        'file': [
          await MultipartFile.fromFile(photo!.path,
              filename: photo!.name + '.jpg' )
        ],
        'deviceSerialNumber': deviceSerialNumber,
        'deviceID': deviceID,
        'deviceGuid': deviceGuid,
        'userID' : userID
      });
      _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $accessToken';
          return handler.next(options);
        },
      ));
      var response = await _dio.request(
        CUSTOMER_DEVICE_UPLOAD_FILE_API,
        options: Options(
          method: 'POST',
          contentType: 'multipart/form-data',
        ),
        data: data,
      );

      UploadFileResponse uploadFileResponse = UploadFileResponse.fromJson(response.data);
      print(uploadFileResponse.toJson());
      return uploadFileResponse;
    } on DioException catch (e) {
      //returns the error object if there is
      UploadFileResponse uploadFileResponse = UploadFileResponse();
      print("============= ${e.message}");
      if ( e.response!.statusCode == 401 || e.response!.statusCode ==  403) {
        // Handle unauthorized error (e.g., navigate to login screen)
        uploadFileResponse.code = SYSTEM_NOT_AUTHORIZE;
        uploadFileResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_AUTHORIZE);
        uploadFileResponse.message = CommonUtils.ErrorMessage(SYSTEM_NOT_AUTHORIZE);

      } else {
        // Handle other DioError types
        uploadFileResponse.code = SYSTEM_NOT_OK;
        uploadFileResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);
        uploadFileResponse.message = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);

      }
      return uploadFileResponse;
    }
  }

}


