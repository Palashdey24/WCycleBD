import 'package:intl/intl.dart';

const String appName = "WCycleBD";
const String appLogo = "assets/wcycle-bd-hd_logo.png";

final dateFormtter = DateFormat.yMMMEd();

final orderDateFormtter = DateFormat.yMMMMd('en_US').add_jm();

String formatedDate(DateTime date) {
  return dateFormtter.format(date);
}

String formatedOrderDate(DateTime date) {
  return orderDateFormtter.format(date);
}
