import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rizaapp/screen/signin.dart';

import 'config/constant.dart';

void main() async{
  //thêm mới dữ liệu trước khi load hiển thị view
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  _setupDeviceInformation();
  runApp( MyApp());
}
void _setupDeviceInformation() async
{
  const storage = FlutterSecureStorage();
  final deviceInfoPlugin = DeviceInfoPlugin();
  var deviceSerialNumber = await storage.read(key: 'deviceSerialNumber');
  if(deviceSerialNumber == null || deviceSerialNumber.isEmpty)
  {
    //thực hiện lấy ra deviceSerialNumber
    var deviceSerialNumber = "";
    var deviceOSName = "Android";
    if (Platform.isAndroid) {
      deviceOSName = "Android";
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      await storage.write(key: 'deviceSerialNumber', value: androidInfo.id);
      deviceSerialNumber = androidInfo.id;
      await storage.write(key: 'deviceSerialNumberHash', value: calcSHA256Adv(deviceSerialNumber));
      await storage.write(key: 'deviceOSName', value: deviceOSName);


    } else if (Platform.isIOS) {
      deviceOSName = "iOS";
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      await storage.write(key: 'deviceSerialNumber', value: iosInfo.identifierForVendor);
      deviceSerialNumber = iosInfo.identifierForVendor!;

      await storage.write(key: 'deviceSerialNumber', value: deviceSerialNumber);
      await storage.write(key: 'deviceSerialNumberHash', value: calcSHA256Adv(deviceSerialNumber));
      await storage.write(key: 'deviceOSName', value: deviceOSName);
    }
  }
}
class MyApp extends StatelessWidget {

  MyApp({super.key});
  @override
  initState()  {
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riza',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        //primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: SigninPage(),
    );
  }
}