
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rizaapp/screen/scan_qrcode_page.dart';
import 'package:rizaapp/screen/signin.dart';

import '../config/constant.dart';
import '../controllers/rizaapp_api_service.dart';
import '../model/baseresponse.dart';
import 'home_page.dart';




class TabHomePage extends StatefulWidget {
  const TabHomePage({super.key});

  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> with WidgetsBindingObserver{
  RizaAppApiManController rizaappApiManController = RizaAppApiManController();
  late DashboardDetails dashboardDetail = DashboardDetails()
  ..totalDeviceUploadToday = 0
  ..totalDeviceUploadToday =0;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _getDashboardInfo();
  }
  void _getDashboardInfo() async
  {
    var checkResult = await rizaappApiManController.dashboard();
    if(checkResult.code! < 0)
    {
      if(checkResult.code == SYSTEM_NOT_AUTHORIZE) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SigninPage()), (Route<dynamic> route) => false);
        Fluttertoast.showToast(msg: checkResult.message!,
            toastLength: Toast.LENGTH_SHORT);
        return;
      }
      else
      {
        Fluttertoast.showToast(msg: checkResult.message!,
            toastLength: Toast.LENGTH_SHORT);
        return;
      }
    }
    else
      {
        setState(() {
          dashboardDetail = checkResult.details!;
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    //reload dashboard
    return Scaffold(
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
        title: const Text("Home"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Card(
                    child: Column
                      (
                      children: [
                        const Text("Total Devices",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Text(dashboardDetail.totalDeviceActive.toString(),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Card(
                    child: Column
                      (
                      children: [
                        const Text("Total Uploads Today",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Text(dashboardDetail.totalDeviceUploadToday.toString(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],),
            SizedBox(height: 16,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePageSeleted(1)));
                    },
                    icon: const Icon(Icons.devices),
                    label: const Text("Devices"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16), // Adjust the vertical padding as needed
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const HomePageSeleted(2)));
                    },
                    icon: const Icon(Icons.settings),
                    label: const Text("Settings"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16), // Adjust the vertical padding as needed
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ScanQRCodePage()));
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Scan QR"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16), // Adjust the vertical padding as needed
                    ),
                  ),
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: (){
                      Fluttertoast.showToast(msg: "Functionality is under construction",
                          toastLength: Toast.LENGTH_SHORT);
                      return;
                      /*Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const HomePageSeleted(2)));*/
                    },
                    icon: const Icon(Icons.handyman),
                    label: const Text("Manual"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16), // Adjust the vertical padding as needed
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
