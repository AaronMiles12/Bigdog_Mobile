import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class LoaderService {
  showSnackbar(title, message) {
    Get.snackbar(title, message,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xffDD075E));
  }
}

class LoadingController extends GetxController {
  RxBool loadingon = false.obs;
  void loadingswitch() {
    loadingon.value = !loadingon.value;
  }
}
