
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rizaapp/screen/signin.dart';
import '../config/constant.dart';
import '../controllers/rizaapp_api_service.dart';
import '../model/customer.dart';
import 'customer_device_detail_page.dart';

class CustomerV2Page extends StatefulWidget {
  const CustomerV2Page({super.key});

  @override
  _CustomerV2PageState createState() => _CustomerV2PageState();
}

class _CustomerV2PageState extends State<CustomerV2Page> with WidgetsBindingObserver {
  bool isCompleteConfigTelegram = false;
  int totalCount = 0;
  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  final storage = FlutterSecureStorage();
  TextEditingController _txtSearch = TextEditingController();

  RizaAppApiManController rizaappApiManController = RizaAppApiManController();
  late List<CustomerDeviceDetail> futureCustomers = [];
  int pageNumber = 1;
  String customerName = "";
  String deviceSerialNumberHash = "";
  int  status = 0;
  DateTime fromDate = DateTime.now().subtract(Duration(days: 365));
  DateTime toDate = DateTime.now();
  late ScrollController _scrollController;
  bool isFirstLoadRunning = false;
  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  void _loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300
    ) {
      setState(() {
        isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      pageNumber += 1; // Increase _page by 1
      try {
        var dataMore = Future.value(await fetchCustomerDetailLoadMore(pageNumber));
        if (dataMore!=null) {
          setState(() {
            dataMore.then((value) {
              if (value != null) value.forEach((item) => futureCustomers.add(item));
            });
          });
        } else {
          setState(() {
            hasNextPage = false;
          });
        }
      } catch (err) {
        Fluttertoast.showToast(msg: "System error please contact admin",
            toastLength: Toast.LENGTH_SHORT);
      }

      setState(() {
        isLoadMoreRunning = false;
      });
    }
  }
  void _firstLoad() async {
    setState(() {
      isFirstLoadRunning = true;
    });
    var dataMore = Future.value(await fetchCustomerDetailLoadMore(pageNumber));
    dataMore.then((value) {
      if (value != null) value.forEach((item) => futureCustomers.add(item));
    });
    setState(() {
      isFirstLoadRunning = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _firstLoad();
    _scrollController = ScrollController();
    _scrollController.addListener(_loadMore);
  }

  Future<List<CustomerDeviceDetail>?> fetchCustomerDetailLoadMore(int pageNew) async {
    var checkResult =  await rizaappApiManController.customerDeviceList(pageNew, deviceSerialNumberHash, customerName, status, fromDate, toDate);
    if(checkResult.code! < 0)
    {
      if(checkResult.code == SYSTEM_NOT_AUTHORIZE) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SigninPage()), (Route<dynamic> route) => false);
        Fluttertoast.showToast(msg: checkResult.message!,
            toastLength: Toast.LENGTH_SHORT);
        return  [];
      }
    }
    else
      {
        setState(() {
          totalCount = checkResult.total!;
        });
      }
    return checkResult.data;
  }
  @override
  void dispose() {
    super.dispose();
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
                color: Colors.white,
                height: 1.0,
              )),
          title: const Text("List of Devices"),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          /*leading: const BackButton(
            color: Colors.black, // Change the color here
          ),
          automaticallyImplyLeading: false,*/
        ),
       body: Container(
         padding: const EdgeInsets.all(8),
         child: isFirstLoadRunning?const Center(
           child: CircularProgressIndicator(),
         ):
         Column(
             children: [
               Row(
                 children: [
                   Expanded(
                     flex: 3,
                     child:TextFormField(
                       controller: _txtSearch,
                       textAlignVertical: TextAlignVertical.bottom,
                       maxLines: 1,
                       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                       onChanged: (textValue) {

                         setState(() {
                           deviceSerialNumberHash = textValue;
                         });
                       },
                       decoration: InputDecoration(
                         fillColor: Colors.grey[100],
                         filled: true,
                         hintText: 'Device information',
                         prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                         suffixIcon: (_txtSearch.text == '')
                             ? null
                             : GestureDetector(
                             onTap: () {
                               setState(() {
                                 _txtSearch = TextEditingController(text: '');
                                 isFirstLoadRunning = true;
                                 futureCustomers = [];
                                 deviceSerialNumberHash = "";
                               });
                               _firstLoad();
                             },
                             child: Icon(Icons.close,
                                 color: Colors.grey[500])),
                         focusedBorder: UnderlineInputBorder(
                             borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                             borderSide: BorderSide(color: Colors.grey[200]!)),
                         enabledBorder: UnderlineInputBorder(
                           borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                           borderSide: BorderSide(color: Colors.grey[200]!),
                         ),
                       ),
                     ),
                   ),
                   const SizedBox(
                     width: 8,
                   ),
                   Expanded(
                     flex: 2,
                     child:  ElevatedButton (
                       child:  Text("Search"),
                       onPressed: () async{
                         var page = 1;
                         var dataMore = await fetchCustomerDetailLoadMore(page);
                         futureCustomers = [];
                         setState(() {
                           futureCustomers = dataMore!;
                         });
                       },
                     ),
                   ),
                   const SizedBox(
                     width: 8,
                   ),
                 ],
               ),
               const SizedBox(
                 height: 16,
               ),
               Row(
                 children: [
                   Expanded(
                     flex: 1,
                     child:    RichText(
                       text: TextSpan(
                           children: <TextSpan>[
                             const TextSpan(
                               text: "Total devices: ",
                               style: TextStyle(
                                 color: Colors.black,
                               ),
                             ),
                             TextSpan(
                                 text: totalCount == 0 || totalCount == null ? "" : totalCount.toString(),
                                 style: const TextStyle(
                                   color: Colors.blue,
                                   fontWeight: FontWeight.bold,
                                 )
                             ),
                           ]
                       ),

                     ),
                   ),
                 ],
               ),
               const SizedBox(
                 height: 8,
               ),
               Expanded(
                 child: ListView.builder(
                   itemCount: futureCustomers.length,
                   controller: _scrollController,
                   itemBuilder: (BuildContext context, int index) => Card(
                     shape: RoundedRectangleBorder
                       (
                     ),
                     margin: const EdgeInsets.symmetric(
                         vertical: 4, horizontal: 8),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         Expanded(
                           flex: 1,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(height: 8,),
                               RichText(
                                 text: TextSpan(
                                     children: <TextSpan>[
                                       const TextSpan(
                                         text: "Device Name: ",
                                         style: TextStyle(
                                           color: Colors.black,
                                         ),
                                       ),
                                       TextSpan(
                                           text: futureCustomers[index].deviceName == null ? "" : futureCustomers[index].deviceName,
                                           style: const TextStyle(
                                             color: Colors.blue,
                                             fontWeight: FontWeight.bold,
                                           )
                                       ),
                                     ]
                                 ),

                               ),
                               SizedBox(height: 8,),
                               RichText(
                                 text: TextSpan(
                                     children: <TextSpan>[
                                       const TextSpan(
                                         text: "Category Name: ",
                                         style: TextStyle(
                                           color: Colors.black,
                                         ),
                                       ),
                                       TextSpan(
                                           text: futureCustomers[index].deviceCategoryName == null ? "" : futureCustomers[index].deviceCategoryName,
                                           style: const TextStyle(
                                             color: Colors.blue,
                                             fontWeight: FontWeight.bold,
                                           )
                                       ),
                                     ]
                                 ),

                               ),
                               SizedBox(height: 8,),
                               RichText(
                                 text: TextSpan(
                                     children: <TextSpan>[
                                       const TextSpan(
                                         text: "Description: ",
                                         style: TextStyle(
                                           color: Colors.black,
                                         ),
                                       ),
                                       TextSpan(
                                           text: futureCustomers[index].description == null ? "" : futureCustomers[index].description,
                                           style: const TextStyle(
                                             color: Colors.lightGreen,
                                             fontWeight: FontWeight.bold,
                                           )
                                       ),
                                     ]
                                 ),

                               ),
                               SizedBox(height: 8,),
                               RichText(
                                 text: TextSpan(
                                     children: <TextSpan>[
                                       const TextSpan(
                                         text: "Company Name: ",
                                         style: TextStyle(
                                           color: Colors.black,
                                         ),
                                       ),
                                       TextSpan(
                                           text:  futureCustomers[index].companyName == null ? "" : futureCustomers[index].companyName,
                                           style: const TextStyle(
                                             color: Colors.blue,
                                             fontWeight: FontWeight.bold,
                                           )
                                       ),
                                     ]
                                 ),

                               ),
                               SizedBox(height: 8,),
                               RichText(
                                 text: TextSpan(
                                     children: <TextSpan>[
                                       const TextSpan(
                                         text: "Device SerialNum: ",
                                         style: TextStyle(
                                           color: Colors.black,
                                         ),
                                       ),
                                       TextSpan(
                                           text: futureCustomers[index].deviceSerialNum == null ? "" : futureCustomers[index].deviceSerialNum,
                                           style: const TextStyle(
                                             color: Colors.orange,
                                             fontWeight: FontWeight.bold,
                                           )
                                       ),
                                     ]
                                 ),

                               ),
                               SizedBox(height: 8,),
                               RichText(
                                 text: TextSpan(
                                     children: <TextSpan>[
                                       const TextSpan(
                                         text: "Created On: ",
                                         style: TextStyle(
                                           color: Colors.black,
                                         ),
                                       ),
                                       TextSpan(
                                           text: formatDateVN(futureCustomers[index].createdOn!),
                                           style: const TextStyle(
                                             color: Colors.green,
                                             fontWeight: FontWeight.bold,
                                           )
                                       ),
                                     ]
                                 ),

                               ),
                               SizedBox(height: 8,),

                             ],
                           ),
                         ),
                         Expanded(
                           flex: 1,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.end,
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               SizedBox(height: 8,),
                               Container(
                                 width: 200,
                                 child: ElevatedButton.icon(
                                   onPressed: (){
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => CustomerDeviceDetailPage(futureCustomers[index])
                                       ),
                                     );
                                   },

                                   icon: const Icon(Icons.calendar_month),
                                   label: const Text("View"),
                                 ),
                               ),
                               SizedBox(height: 8,),
                               Container(
                                 width: 200,
                                 child: ElevatedButton.icon(
                                   onPressed: () async{
                                     XFile? imageFile = await captureImage();
                                     if (imageFile != null) {
                                       var checkResult = await rizaappApiManController.uploadDeviceFile(imageFile,
                                           futureCustomers[index].deviceSerialNum!,
                                           futureCustomers[index]!.id.toString(),
                                           futureCustomers[index].deviceGuid!);
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
                                           return;
                                           }
                                         }
                                     }
                                   },
                                   icon: const Icon(Icons.upload_file),
                                   label: const Text("Upload File"),
                                 ),
                               ),
                               SizedBox(height: 8,),
                               Container(
                                 width: 200,
                                 child: ElevatedButton.icon(
                                   onPressed: (){
                                     Fluttertoast.showToast(msg: "Functionality is under construction",
                                         toastLength: Toast.LENGTH_SHORT);
                                   },
                                   icon: const Icon(Icons.handyman),
                                   label: const Text("Manual"),
                                 ),
                               ),
                             ],
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
               )
             ]
         ),
       )
      ),
    );
  }
}

