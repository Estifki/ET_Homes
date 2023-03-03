import 'package:flutter/material.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:real_estate_project/const/const.dart';

showErrorMessage(double width, BuildContext context, String errorMessage) {
  return MotionToast.info(
    width: width,

    height: 40,
    iconSize: 0.0,
    padding: const EdgeInsets.only(top: 10),
    // title: const Text(
    //   'Error',
    //   style: TextStyle(
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
    description: Text(
      errorMessage,
      style: const TextStyle(
          fontSize: 15, fontFamily: AppFonts.medium, color: Colors.black),
    ),
    animationType: AnimationType.fromTop,
    position: MotionToastPosition.top,
    barrierColor: Colors.black.withOpacity(0.3),
    animationDuration: const Duration(milliseconds: 500),
    toastDuration: const Duration(milliseconds: 2000),
    borderRadius: 8,
  ).show(context);
}

showSuccessMessage(double width, BuildContext context, String successMessage) {
  return MotionToast.success(
    width: width,
    height: 40,
    iconSize: 0.0,
    padding: const EdgeInsets.only(top: 10),
    // title: const Text(
    //   'Error',
    //   style: TextStyle(
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
    description: Text(
      successMessage,
      style: const TextStyle(
          fontSize: 15, fontFamily: AppFonts.medium, color: Colors.black),
    ),
    animationType: AnimationType.fromTop,

    position: MotionToastPosition.top,
    barrierColor: Colors.black.withOpacity(0.3),
    animationDuration: const Duration(milliseconds: 500),

    toastDuration: const Duration(milliseconds: 2000),
    borderRadius: 8,
  ).show(context);
}
