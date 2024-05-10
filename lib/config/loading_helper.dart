import 'package:flutter/material.dart';
void ShowLoadingDialog(BuildContext context)
{
  AlertDialog alert = AlertDialog(
    content: Row(children: [
      CircularProgressIndicator(
        backgroundColor: Colors.blue,
      ),
      Container(margin: EdgeInsets.only(left: 7), child: Text("Đang xử lý dữ liệu...")),
    ]),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
void HideLoadingDialog(BuildContext context)
{
  Navigator.pop(context);
}