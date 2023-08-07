import 'dart:io';

import 'package:flutter/foundation.dart';

logError(dynamic message, [dynamic content]) {
  printStr('Err $message ❗\t${content??''}', red);
}

logApiRequest(dynamic message) {
  printStr('${message??''}', yellow);
}

logApiResponse(dynamic message) {
  printStr('${message??''}', cyan);
}

logApiError(dynamic message) {
  printStr('Err $message}', red);
}

logPrefsStore(String key, dynamic data) {
  printStr('💾 Writing $key: ${data??''}', black);
}

logInfo(dynamic message, [dynamic content]) {
  printStr('ℹ️ $message .\t${content??''}', blue);
}


printStr(String message, int color) {
  if(kDebugMode) {
    print('${getColor(color)} $message ${getColor(reset)}');
    if(message.length>200){
      print(getColor(reset));
    }
  }
}


String getColor(int code) {
  String m = 'm';
  return Platform.isAndroid?'\x1B[$code$m':'';
}

const int black = 30; //less thick
const int red = 31; //error, API error
const int green = 32; //success
const int yellow = 33; //API request
const int blue = 34; //info
const int magenta = 35; //screen
const int cyan = 36; //API response
const int white = 37; ///dull than normal
const int reset = 0; //reset to default