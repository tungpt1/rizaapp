import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rizaapp/screen/home.dart';
import 'package:rizaapp/screen/signin.dart';
import '../config/constant.dart';
import '../controllers/rizaapp_api_service.dart';
import '../model/customer.dart';
class ScanQRCodeDetailPage extends StatefulWidget {
  //final IsarService service;
  final CustomerDeviceDetail customerDeviceDetail;
  const ScanQRCodeDetailPage(this.customerDeviceDetail , {Key? key}) : super(key: key);

  @override
  State<ScanQRCodeDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<ScanQRCodeDetailPage> with WidgetsBindingObserver{
  RizaAppApiManController rizaappApiManController = RizaAppApiManController();

  @override
  void dispose() {
    super.dispose();
  }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        title: const Text("Device Information"),
        backgroundColor: Colors.white,
      ),
      body:   Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 16,),
                  RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: "Device Name: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: widget.customerDeviceDetail.deviceName == null ? "" : widget.customerDeviceDetail.deviceName,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ]
                    ),

                  ),
                  SizedBox(height: 16,),
                  RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: "Category Name: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: widget.customerDeviceDetail.deviceCategoryName == null ? "" : widget.customerDeviceDetail.deviceCategoryName,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ]
                    ),

                  ),
                  SizedBox(height: 16,),
                  RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: "Description: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: widget.customerDeviceDetail.description == null ? "" : widget.customerDeviceDetail.description,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ]
                    ),

                  ),
                  SizedBox(height: 16,),
                  RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: "Company Name: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: widget.customerDeviceDetail.companyName!,
                              style: const TextStyle(
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ]
                    ),

                  ),
                  SizedBox(height: 16,),
                  RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: "Device SerialNum: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: truncateWithEllipsis(20,widget.customerDeviceDetail.deviceSerialNum!),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ]
                    ),

                  ),
                  SizedBox(height: 16,),
                  RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: "Created On: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: formatDateVN(widget.customerDeviceDetail.createdOn!),
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ]
                    ),

                  ),
                  SizedBox(height: 16,),
                ],
              ),
            ),
            Expanded(
              flex:  1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: ()  async {
                      XFile? imageFile = await captureImage();
                      if (imageFile != null) {
                        var checkResult = await rizaappApiManController.uploadDeviceFile(imageFile,
                            widget.customerDeviceDetail.deviceSerialNum!,
                            widget.customerDeviceDetail!.id.toString(),
                            widget.customerDeviceDetail.deviceGuid!);
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
                          if(checkResult.code == SYSTEM_OK) {
                            Fluttertoast.showToast(msg: "Upload file success",
                                toastLength: Toast.LENGTH_SHORT);
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
                          }
                        }
                      }
                    },
                    label: const Text('Upload File'),
                    icon : const Icon(
                      Icons.upload_file,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: ()  async {
                      Navigator.pop(context);
                    },
                    label: const Text('Manual'),
                    icon : const Icon(
                      Icons.handyman,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: null,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex:  1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: ()  async {
                      Navigator.pop(context);
                    },
                    label: const Text('Cancel'),
                    icon : const Icon(
                      Icons.exit_to_app,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: null,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
