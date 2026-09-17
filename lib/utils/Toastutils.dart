import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toastutils {
  static bool showLoading = false;
  static void showToast(BuildContext context, String? msg) {
    if (Toastutils.showLoading) {
      return;
    }
    Toastutils.showLoading = true;
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(40),
            ),
            behavior: SnackBarBehavior.fixed, // 改为 fixed，避免 floating 在某些布局下超出屏幕
            duration: Duration(seconds: 2),
            content: Text(msg ?? '加载成功', textAlign: TextAlign.center),
          ),
        )
        .closed
        .then((_) {
          // SnackBar 关闭后重置标志，允许下次再弹出提示
          Toastutils.showLoading = false;
        });
  }
}
