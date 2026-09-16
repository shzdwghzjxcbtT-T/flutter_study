import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toastutils {
  static bool showLoading = false;
  static void showToast(BuildContext context, String? msg) {
    if (Toastutils.showLoading) {
      return;
    }
    Toastutils.showLoading = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        content: Text(msg ?? '加载成功', textAlign: TextAlign.center),
      ),
    );
  }
}
