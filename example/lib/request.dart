import 'package:intl/intl.dart';

class Request {
  late final String timeStamp;
  final String icon;
  final String message;

  Request(this.icon, this.message) {
    timeStamp = DateFormat('hh:mm:ss').format(DateTime.now());
  }
}
