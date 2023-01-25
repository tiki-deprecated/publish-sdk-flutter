import 'dart:convert';

class DestinationModel {
  String body = "{\"message\" : \"Hello Tiki!\"}";
  String httpMethod = "POST";
  int interval = 15;
  String url = "https://postman-echo.com/post";

  String get source => base64Url.encode(body.codeUnits);
}
