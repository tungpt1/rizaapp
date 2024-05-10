
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

const String APP_NAME = 'LD Dragon';

// color for apps
const Color PRIMARY_COLOR = Color(0xFF0181cc);
const Color ASSENT_COLOR = Color(0xFFe75f3f);
const Color SECOND_COLOR = Color(0xFF555555);

const Color BLACK21 = Color(0xFF212121);
const Color BLACK55 = Color(0xFF555555);
const Color BLACK77 = Color(0xFF777777);
const Color SOFT_GREY = Color(0xFFaaaaaa);
const Color SOFT_BLUE = Color(0xff01aed6);
const Color WHITE = Color(0xFFFFFFFF);

const Color CHARCOAL = Color(0xFF515151);
const Color BLACK_GREY = Color(0xff777777);


//#region Error Code
const int SYSTEM_OK = 0;

const int LIMIT_PAGE = 8;

const int STATUS_OK = 200;
const int STATUS_BAD_REQUEST = 400;
const int STATUS_NOT_AUTHORIZED = 403;
const int STATUS_NOT_FOUND = 404;
const int STATUS_INTERNAL_ERROR = 500;

const String GLOBAL_URL = 'https://nlapi.the4w.app';
const String SERVER_URL = 'https://rizaapp.the4w.app';
//const String SERVER_URL = 'https:// 10.0.0.2:8081';

const String LOGIN_API = "$SERVER_URL/api/RizaAdminUser/signin";
const String CUSTOMER_DEVICE_LIST_API = "$SERVER_URL/api/RizaAdminUser/customerdevicelist";
const String CUSTOMER_DEVICE_BY_GUID_API = "$SERVER_URL/api/RizaAdminUser/searchdevice";


const String CUSTOMER_DASHBOARD_INFO_API = "$SERVER_URL/api/RizaAdminUser/adminuserdashboard";
//kiểm soát xem còn phiên làm việc
const String CUSTOMER_VALID_INFO_API = "$SERVER_URL/api/RizaAdminUser/adminuservalid";
const String CUSTOMER_CHANGE_USER_PASS_API = "$SERVER_URL/api/RizaAdminUser/adminuserchangepassword";

const String CUSTOMER_DEVICE_UPLOAD_FILE_API = "$SERVER_URL/api/RizaAdminUser/uploadfile";



const int CUSTOMER_UPDATE_EXTEND_MONTH = 1;
const int CUSTOMER_UPDATE_EXTEND_YEAR = 2;

const int SYSTEM_NOT_OK = -1;
const int SYSTEM_NOT_AUTHORIZE = -401;

const double SIZE_4 = 4.0;
const double SIZE_6 = 6.0;
const double SIZE_8 = 8.0;
const double SIZE_16 = 16.0;
const double SIZE_24 = 24.0;
const double SIZE_32 = 32.0;


const double ICON_SIZE_16 = 16.0;
const double ICON_SIZE_24 = 24.0;
const double ICON_SIZE_32 = 32.0;

const double SIZEDBOX_WIDTH_4 = 4.0;
const double SIZEDBOX_WIDTH_6 = 6.0;
const double SIZEDBOX_WIDTH_12 = 12.0;
const double SIZEDBOX_WIDTH_24 = 24.0;

//setting for EdgeInsets
const double EDGE_ALL = 8.0;

const double EDGE_HORIZONTAL = 8.0;
const double EDGE_VERTICAL = 8.0;
const double EDGE_TOP = 8.0;
const double EDGE_BOTTOM = 8.0;



class CommonUtils {
  static String ErrorMessage(int errorCode) {
    switch(errorCode) {
      case SYSTEM_NOT_OK:
        return "System error";
      case SYSTEM_NOT_AUTHORIZE:
        return "Session timeout, please login again";
      default:
        return "System error";
    }
  }
}

String formatDateVN(String date)
{
  DateTime parseDate =
  new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
  var outputFormat = DateFormat('dd/MM/yyyy');
  return outputFormat.format(parseDate).toString();
}
String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}

double formatDouble(double val){
  num mod = pow(10.0, 1);
  return ((val * mod).round().toDouble() / mod);
}


String wordWrap(String text, int maxLineLength) {
  List<String> words = text.split(' ');
  String wrappedText = '';
  String currentLine = '';
  int currentLineLength = 0;

  for (String word in words) {
    if (currentLine.isEmpty) {
      currentLine = word;
      currentLineLength = word.length;
    } else if (currentLineLength + word.length + 1 <= maxLineLength) {
      currentLine += ' $word';
      currentLineLength += word.length + 1;
    } else {
      wrappedText += '$currentLine\n';
      currentLine = word;
      currentLineLength = word.length;
    }
  }

  wrappedText += currentLine; // Add the last line

  return wrappedText;
}
String removeUnicode(String text) {
  List<String> arr1 = [
    "á", "à", "ả", "ã", "ạ", "â", "ấ", "ầ", "ẩ", "ẫ", "ậ", "ă", "ắ", "ằ", "ẳ", "ẵ", "ặ",
    "đ",
    "é", "è", "ẻ", "ẽ", "ẹ", "ê", "ế", "ề", "ể", "ễ", "ệ",
    "í", "ì", "ỉ", "ĩ", "ị",
    "ó", "ò", "ỏ", "õ", "ọ", "ô", "ố", "ồ", "ổ", "ỗ", "ộ", "ơ", "ớ", "ờ", "ở", "ỡ", "ợ",
    "ú", "ù", "ủ", "ũ", "ụ", "ư", "ứ", "ừ", "ử", "ữ", "ự",
    "ý", "ỳ", "ỷ", "ỹ", "ỵ",
  ];

  List<String> arr2 = [
    "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a",
    "d",
    "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e",
    "i", "i", "i", "i", "i",
    "o", "o", "o", "o", "o", "o", "o", "o", "o", "o", "o", "o", "o", "o", "o", "o", "o",
    "u", "u", "u", "u", "u", "u", "u", "u", "u", "u", "u",
    "y", "y", "y", "y", "y",
  ];

  for (int i = 0; i < arr1.length; i++) {
    text = text.replaceAll(arr1[i], arr2[i]);
    text = text.replaceAll(arr1[i].toUpperCase(), arr2[i].toUpperCase());
  }

  return text;
}

String calcSHA256(String inputData)
{
  var bytes = utf8.encode(inputData); // data being hashed
  var digest = sha1.convert(bytes);
  return digest.toString();
}
String calcSHA256Adv(String inputData)
{
  var bytes = utf8.encode("${inputData}soft2023Nov"); // data being hashed
  var digest = sha256.convert(bytes);
  return digest.toString();
}
String calcMD5Adv(String inputData)
{
  var bytes = utf8.encode("${inputData}soft2023Nov"); // data being hashed
  var digest = md5.convert(bytes);
  return digest.toString();
}
extension StringExtension on String {
  String deleteLastChar({int toDelete = 1}) => substring(0, length - toDelete);
}

extension on String {
  //toArray1 method
  List toArray1() {
    List items = [];
    for (var i = 0; i < this.length; i++) {
      items.add(this[i]);
    }
    return items;
  }

  //toArray2 method
  List toArray2() {
    List items = [];
    this.split("").forEach((item) => items.add(item));
    return items;
  }
}


bool isLastCharacterDigit(String input) {
  if (input.isNotEmpty) {
    String lastCharacter = input.substring(input.length - 1);
    return int.tryParse(lastCharacter) != null;
  }
  return false;
}

int countOccurrencesUsingWhere(List<String> values, String element) {
  return values.where((e) => e == element).length;
}

Future<XFile?> captureImage() async {
  final picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: ImageSource.camera);

  if (photo != null) {
    return photo;
  } else {
    return null;
  }
}