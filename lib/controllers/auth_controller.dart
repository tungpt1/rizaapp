import 'dart:convert';
import 'package:flutter/material.dart';
import '/model/user.dart';
import '/config/constant.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '/model/baseresponse.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Dio _dio = Dio();
  final storage = const FlutterSecureStorage();
  Future<BaseResponse> loginUser() async {
    try {
      var deviceSerialNumber = await storage.read(key: 'deviceSerialNumber');
      var deviceOSName = await storage.read(key: 'deviceOSName');

      Response response = await _dio.post(LOGIN_API,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode({
          "emailOrPhoneNo": usernameController.text,
          "password": passwordController.text,
          "deviceSerialNumber": deviceSerialNumber,
          "deviceOSName": deviceOSName,
        }),
      );
      print(response.data);
      LoginResponse dataUser = LoginResponse.fromJson(response.data);
      BaseResponse baseResponse = BaseResponse();
      baseResponse.code = dataUser.code;
      baseResponse.errorMessage = dataUser.message;
      if(dataUser.code == 0)
      {
        //print("login success");
        if(dataUser.details!.accessToken!=null)
        {
          await storage.write(key: 'accessToken', value: dataUser.details!.accessToken);
          await storage.write(key: 'userID', value: dataUser.details!.userID.toString());
          await storage.write(key: 'refreshToken', value: dataUser.details!.refreshToken.toString());
          await storage.write(key: 'emailOrPhoneNo', value: usernameController.text);
        }
        return baseResponse;
      }
      else
      {
        //print("login fail");
        return baseResponse;
      }
    } on DioException  catch (e) {
      print("======================${e.message} ${LOGIN_API}");
      //returns the error object if there is
      BaseResponse baseResponse = BaseResponse();
      baseResponse.code = SYSTEM_NOT_OK;
      baseResponse.errorMessage = CommonUtils.ErrorMessage(SYSTEM_NOT_OK);
      return baseResponse;
    }
  }
}