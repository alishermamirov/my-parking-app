import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
static void showSuccess(BuildContext context, String message) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      title: Text(
        "Success",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      description: Text(
        message,
        style: const TextStyle(color: Colors.white70),
      ),
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 2),
      backgroundColor: Colors.green.shade600,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      borderRadius: BorderRadius.circular(16),
      animationDuration: const Duration(milliseconds: 350),
    );
  }

  static void showError(BuildContext context, String message) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      title: Text(
        "Error",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      description: Text(
        message,
        style: const TextStyle(color: Colors.white70),
      ),
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 3),
      backgroundColor: Colors.red.shade600,
      icon: const Icon(Icons.error, color: Colors.white),
      borderRadius: BorderRadius.circular(16),
      animationDuration: const Duration(milliseconds: 350),
    );
  }
}
