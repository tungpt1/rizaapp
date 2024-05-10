import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rizaapp/screen/scan_qrcode_detail_page.dart';
import 'package:rizaapp/screen/scanner_error_widget.dart';
import 'package:rizaapp/screen/signin.dart';

import '../config/constant.dart';
import '../controllers/rizaapp_api_service.dart';

class ScanQRCodePage extends StatefulWidget {
  const ScanQRCodePage({super.key});

  @override
  _ScanQRCodePageState createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  BarcodeCapture? capture;
  RizaAppApiManController rizaappApiManController = RizaAppApiManController();

  @override
  void initState() {
    super.initState();
    _getValidInfo();
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
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Device QR Code')),
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                fit: BoxFit.contain,
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                onDetect: (capture) {
                  setState(() {
                    this.capture = capture;
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 120,
                  color: Colors.black.withOpacity(0.4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 120,
                          height: 50,
                          child: FittedBox(
                            child: Text(
                              capture?.barcodes.first.rawValue ??
                                  'Please Scan QR',
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 120,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: capture?.barcodes?.first.rawValue == null ? null : () async {
                              var deviceGuid = capture?.barcodes?.first.rawValue;
                              if(deviceGuid==null || deviceGuid.isEmpty)
                              {
                                Fluttertoast.showToast(msg: "Invalid QR Code",
                                    toastLength: Toast.LENGTH_SHORT);
                                return;
                              }
                              var searchDevice = await rizaappApiManController.customerDeviceByGuid(deviceGuid, deviceGuid);
                              if(searchDevice.code! < 0)
                              {
                                if(searchDevice.code == SYSTEM_NOT_AUTHORIZE) {
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SigninPage()), (Route<dynamic> route) => false);
                                  Fluttertoast.showToast(msg: searchDevice.message!,
                                      toastLength: Toast.LENGTH_SHORT);
                                  return;
                                }
                                else
                                {
                                  Fluttertoast.showToast(msg: searchDevice.message!,
                                      toastLength: Toast.LENGTH_SHORT);
                                  return;
                                }
                              }
                              else
                              {
                                if(searchDevice.code == SYSTEM_OK) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScanQRCodeDetailPage(searchDevice.details!),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text('Check Device'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

