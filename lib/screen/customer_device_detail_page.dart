import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rizaapp/screen/signin.dart';
import '../config/constant.dart';
import '../controllers/rizaapp_api_service.dart';
import '../model/customer.dart';
import 'home_page.dart';
class CustomerDetailPage extends StatefulWidget {
  //final IsarService service;
  final CustomerDeviceDetail customerDetail;
  const CustomerDetailPage(this.customerDetail , {Key? key}) : super(key: key);

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> with WidgetsBindingObserver{
  LdDragonApiManController ldDragonApiManController = LdDragonApiManController();

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
    var checkResult = await ldDragonApiManController.userValid();
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
        title: const Text("Chi Tiết Khách Hàng"),
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
                              text: widget.customerDetail.deviceName == null ? "" : widget.customerDetail.deviceName,
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
                              text: widget.customerDetail.deviceCategoryName == null ? "" : widget.customerDetail.deviceCategoryName,
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
                              text: widget.customerDetail.description == null ? "" : widget.customerDetail.description,
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
                              text: widget.customerDetail.companyName!,
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
                              text: truncateWithEllipsis(20,widget.customerDetail.deviceSerialNum!),
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
                              text: formatDateVN(widget.customerDetail.createdOn!),
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
                      Navigator.pop(context);
                    },
                    label: const Text('Hủy'),
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
