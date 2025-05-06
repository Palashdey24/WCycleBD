import 'package:intl/intl.dart';

const String appName = "WCycleBD";
const String appLogo = "assets/wcycle-bd-hd_logo.png";

final dateFormtter = DateFormat.yMMMEd();

String getSqlTableName(String? uId) {
  final tableName = "newcarts";
  return tableName;
}

String formatedDate(DateTime date) {
  return dateFormtter.format(date);
}
