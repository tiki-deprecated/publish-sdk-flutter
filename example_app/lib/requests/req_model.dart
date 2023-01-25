import 'package:intl/intl.dart';

class RequestModel {
  late final String timeStamp;
  final String icon;
  final String message;

  RequestModel(this.icon, this.message){
    timeStamp = DateFormat('hh:mm:ss').format(DateTime.now());
  }
}
