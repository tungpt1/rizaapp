
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rizaapp/screen/signin.dart';
import '../controllers/rizaapp_api_service.dart';
import '/config/constant.dart';


class SettingChangePasswordPage extends StatefulWidget {
  const SettingChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<SettingChangePasswordPage> createState() => _SettingChangePasswordPageState();
}

class _SettingChangePasswordPageState extends State<SettingChangePasswordPage> with WidgetsBindingObserver{
  LdDragonApiManController ldDragonApiManController = LdDragonApiManController();
  List<bool> isSelected2 = [false, true ];

  final _txtOldPassword = TextEditingController();
  final _txtPassword = TextEditingController();
  final _txtPasswordRetype = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool enableEnablPasswordClear = false;
  //bật mắt cho o text box
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;
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
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _getValidInfo();
  }
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
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
            title: const Text("Đổi Mật Khẩu"),
          ),
          body:
          Form(
            key: _formKey,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(SIZE_8),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: TextFormField(
                        controller: _txtOldPassword,
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty ) {
                            if(enableEnablPasswordClear == true)
                            {
                              return "Hãy nhập mật khẩu cũ";
                            }
                          }
                          return null;
                        },
                        style: const TextStyle(color: BLACK21),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                          ),
                          labelText: 'Mật Khẩu Cũ',
                          suffixIcon: IconButton(
                              icon: Icon(_iconVisible, color: Colors.grey[700], size: 20),
                              onPressed: () {
                                _toggleObscureText();
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SIZE_8,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _txtPassword,
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty ) {
                            if(enableEnablPasswordClear == true)
                            {
                              return "Hãy nhập mật khẩu mới";
                            }
                          }
                          if(value!.isNotEmpty && value!.length < 6)
                          {
                            return "Mật khẩu phải có độ dài từ 6 ký tự";
                          }
                          return null;
                        },
                        style: const TextStyle(color: BLACK21),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                          ),
                          labelText: 'Mật Khẩu Mới',
                          suffixIcon: IconButton(
                              icon: Icon(_iconVisible, color: Colors.grey[700], size: 20),
                              onPressed: () {
                                _toggleObscureText();
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SIZE_8,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _txtPasswordRetype,
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty  ) {
                            if(enableEnablPasswordClear == true)
                            {
                              return "Hãy điền mật khẩu mới nhập lại";
                            }
                          }
                          if(value!.isNotEmpty && value!.length < 6)
                          {
                            return "Mật khẩu phải có độ dài từ 6 ký tự";
                          }
                          if(_txtPassword.text != value!)
                          {
                            return "Mật khẩu gõ lại không chính xác";
                          }
                          return null;
                        },
                        style: const TextStyle(color: BLACK21),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                          ),
                          labelText: 'Mật Khẩu Mới Nhập Lại',
                          suffixIcon: IconButton(
                              icon: Icon(_iconVisible, color: Colors.grey[700], size: 20),
                              onPressed: () {
                                _toggleObscureText();
                              }),
                        ),

                      ),
                    ),

                    const SizedBox(
                      height: SIZE_8,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: SIZE_8),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) => PRIMARY_COLOR,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if(_txtPassword.text == _txtOldPassword.text)
                                {
                                  Fluttertoast.showToast(msg: "Mật khẩu mới trùng mật khẩu cũ, hãy nhập mật khẩu mới khác",
                                      toastLength: Toast.LENGTH_SHORT);
                                  return;
                                }
                                if(_txtPassword.text != _txtPasswordRetype.text)
                                {
                                  Fluttertoast.showToast(msg: "Mật khẩu gõ lại không chính xác",
                                      toastLength: Toast.LENGTH_SHORT);
                                  return;
                                }
                                //thực hiện gọi cập nhật mật khẩu
                                var checkResult = await ldDragonApiManController.changePassword(_txtOldPassword.text, _txtPasswordRetype.text);
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
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SigninPage()), (Route<dynamic> route) => false);
                                    Fluttertoast.showToast(msg: "Đổi mật khẩu thành công",
                                        toastLength: Toast.LENGTH_SHORT);
                                    return;
                                  }

                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: SIZE_8),
                              child: Text(
                                'Lưu Thông Tin',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            )
                        ),
                      ),
                    ),

                  ],
                )
            ),
          )
      ),
    );
  }
}
