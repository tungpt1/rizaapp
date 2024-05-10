
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rizaapp/screen/setting_change_password.dart';
import 'package:rizaapp/screen/signin.dart';
import '../config/constant.dart';
import '../controllers/rizaapp_api_service.dart';
import '../model/baseresponse.dart';


class TabSettingPage extends StatefulWidget {
  const TabSettingPage({super.key});

  @override
  _TabSettingPageState createState() => _TabSettingPageState();
}

class _TabSettingPageState extends State<TabSettingPage> with WidgetsBindingObserver {
  final storage = FlutterSecureStorage();
  RizaAppApiManController rizaappApiManController = RizaAppApiManController();
  late CustomerSettingDetails customerSettingDetails = CustomerSettingDetails();
  //thông tin cài đặt telegram
  String deviceSerialNumber = "";
  String deviceKeyConfirm = "";
  String phoneNo = "";
  String statusTelegram= "";
  void _setupDeviceInformation() async
  {
    var deviceSerialNumberTmp = await storage.read(key: 'deviceSerialNumber');
    var deviceKeyConfirmTmp = await storage.read(key: 'deviceKeyConfirm');
    var phoneNoTmp = await storage.read(key: 'phoneNo');
    var statusTelegramTmp = await storage.read(key: 'statusTelegram');
    setState(() {

      deviceSerialNumber = deviceSerialNumberTmp!;
      if(deviceKeyConfirmTmp!=null)
      {
        deviceKeyConfirm = deviceKeyConfirmTmp;
      }
      if(phoneNoTmp !=null)
      {
        phoneNo = phoneNoTmp;
      }
      if(statusTelegramTmp !=null)
      {
        statusTelegram = statusTelegramTmp;
      }
    });
  }

  //kiem tra trang thai ung dung
  AppLifecycleState? _notification;

  @override

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupDeviceInformation();
    _getValidInfo();
  }
  @override
  void dispose() {
    super.dispose();
  }



  void _getValidInfo() async
  {
    var checkResult = await rizaappApiManController.userValid();
    if(checkResult.code! < 0)
    {
      if(checkResult.code == SYSTEM_NOT_AUTHORIZE) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SigninPage()), (Route<dynamic> route) => false);
        Fluttertoast.showToast(msg: checkResult.message!,
            toastLength: Toast.LENGTH_SHORT);
        return;
      }
    }
  }
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey[100],
                height: 1.0,
              )),
          title: const Text("Settings"),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: "Application Information",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8,),
                            RichText(
                              text: TextSpan(
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: "Version: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0
                                      ),
                                    ),
                                    TextSpan(
                                        text: "1.0.0",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0
                                        )
                                    ),
                                    TextSpan(
                                        text: " @Copyright BeezFM",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0
                                        )
                                    ),
                                  ]
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container()
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: "Password Status",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4,),
                            RichText(
                              text: TextSpan(
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: "Status: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0
                                      ),
                                    ),
                                    TextSpan(
                                        text: "On",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0
                                        )
                                    ),
                                  ]
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              ElevatedButton.icon(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingChangePasswordPage()
                                    ),
                                  );
                                },
                                label: const Text('Edit'),
                                icon : const Icon(
                                  Icons.edit,
                                  size: ICON_SIZE_24,
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

