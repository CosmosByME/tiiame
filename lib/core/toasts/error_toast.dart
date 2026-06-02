import 'package:fluttertoast/fluttertoast.dart';

void showErrorToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP_RIGHT,
    timeInSecForIosWeb: 2,
    webBgColor: "linear-gradient(to right, #ff4e50, #f9d423)",
    fontSize: 16.0,
  );
}
