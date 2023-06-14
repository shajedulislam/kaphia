import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

Future<bool> isNetworkAvailable() async {
  bool result = await InternetConnectionCheckerPlus().hasConnection;
  return result;
}
