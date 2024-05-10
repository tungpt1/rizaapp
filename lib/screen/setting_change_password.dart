
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
  RizaAppApiManController rizaappApiManController = RizaAppApiManController();
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
            title: const Text("Change Password"),
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
                              return "Old Password";
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
                          labelText: 'Old Password',
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
                              return "Please in put new password";
                            }
                          }
                          if(value!.isNotEmpty && value!.length < 6)
                          {
                            return "New password length > 6 characters";
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
                          labelText: 'New Password',
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
                              return "Please retype new password";
                            }
                          }
                          if(value!.isNotEmpty && value!.length < 6)
                          {
                            return "New password length > 6 characters";
                          }
                          if(_txtPassword.text != value!)
                          {
                            return "Incorect retype password";
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
                          labelText: 'Retype Password',
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
                                  Fluttertoast.showToast(msg: "The new password is the same as the old password, please enter a different new password",
                                      toastLength: Toast.LENGTH_SHORT);
                                  return;
                                }
                                if(_txtPassword.text != _txtPasswordRetype.text)
                                {
                                  Fluttertoast.showToast(msg: "Retyped password is incorrect",
                                      toastLength: Toast.LENGTH_SHORT);
                                  return;
                                }
                                //thực hiện gọi cập nhật mật khẩu
                                var checkResult = await rizaappApiManController.changePassword(_txtOldPassword.text, _txtPasswordRetype.text);
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
                                    Fluttertoast.showToast(msg: "Password changed successfully",
                                        toastLength: Toast.LENGTH_SHORT);
                                    return;
                                  }

                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: SIZE_8),
                              child: Text(
                                'Save',
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
