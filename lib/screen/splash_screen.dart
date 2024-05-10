import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/constant.dart';
import 'home_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Timer? _timer;
  int _second = 3; // set timer for 3 second and then direct to next page
  String? deviceSerialNumber = "";
  String? expiredOn = "";
  void _startTimer() {
    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) async {
      setState(() {
        _second--;
      });
      if (_second == 0) {
        _cancelFlashsaleTimer();

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePageSeleted(0)), (Route<dynamic> route) => false);
      }
    });
  }

  void _cancelFlashsaleTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }


  @override
  void initState() {
    // set status bar color to transparent and navigation bottom color to black21
    SystemChrome.setSystemUIOverlayStyle(
      Platform.isIOS?SystemUiOverlayStyle.light:const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: BLACK21,
          systemNavigationBarIconBrightness: Brightness.light
      ),
    );
    if(_second != 0){
      _startTimer();
    }
    super.initState();
  }

  @override
  void dispose() {
    _cancelFlashsaleTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Container(
            color: WHITE,
            child: Center(
              child: Image.asset('assets/images/beez-logo.jpg', height: 300),
            ),
          ),
        )
    );
  }
}
