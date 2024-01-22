import 'dart:async';
import 'dart:io';

import 'package:big_dog_app/features/onboarding/view/home.dart';
import 'package:big_dog_app/features/onboarding/view/login.dart';
import 'package:big_dog_app/features/onboarding/view/otp.dart';
import 'package:big_dog_app/features/onboarding/view/register.dart';
import 'package:big_dog_app/helpers/loader-snack.dart';
import 'package:big_dog_app/helpers/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class AuthViewModel extends GetxController {
  String LoginType = "";
  bool remembermeToggle = true;
  bool signupagree = false;
  int otpstart = 10;
  int otpcurrent = 0;
  bool otptimercompleted = false;
  Timer? _otpTimer;
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String userAuthToken = "";
  String userRefreshToken = "";
  String selectedType = "";
  String countryCode = "";

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController gendarController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  TextEditingController carnameController = TextEditingController();
  TextEditingController carmodelController = TextEditingController();
  TextEditingController caraboutController = TextEditingController();
  TextEditingController carcolorController = TextEditingController();
  TextEditingController carplateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime selectedYear = DateTime.now();

  final loadingcontroller = Get.put(LoadingController());
  bool isNewUser = false;

  AuthViewModel();

  selectLoginType(loginType) {
    Get.to(() => LoginValidate(logintype: loginType));
  }

  checkLoginValidation(loginType) {
    if (loginType == "email") {
      selectedType = "email";
      if (emailController.text == "") {
        LoaderService()
            .showSnackbar("Error", "Please enter your email address");
      } else {
        sendOtp({
          "email": emailController.text,
          "deviceToken": "none",
          "deviceType": Platform.isAndroid ? "android" : "ios"
        }, "email");
      }
    }
    if (loginType == "phone") {
      selectedType = "phone";

      if (phoneController.text == "") {
        LoaderService().showSnackbar("Error", "Please enter your phone number");
      } else {
        sendOtp({
          "mobileNumber": "${countryCode}${phoneController.text}",
          "deviceToken": "none",
          "deviceType": Platform.isAndroid ? "android" : "ios"
        }, "phone");
      }
    }
  }

  sendOtp(data, type) async {
    print(data);
    print("click");
    loadingcontroller.loadingswitch();
    var resData = await ApiProvider().post('/sso_login', data);
    print(resData);
    loadingcontroller.loadingswitch();

    if (resData != null && resData['status']) {
      LoaderService().showSnackbar("Message", resData['message']);
      _otpTimer?.cancel();

      Get.to(() => OtpScreen(
            type: type,
          ));
    } else {
      // LoaderService().showSnackbar("Message", "Something went wrong.");
    }
  }

  checkLogin() async {
    final storage = FlutterSecureStorage();

    String? value = await storage.read(key: "localuserAuthToken");
    print(value);
    if (value != null) {
      userAuthToken = (await storage.read(key: "localuserAuthToken"))!;
      userRefreshToken = (await storage.read(key: "localuserRefreshToken"))!;
      Get.to(() => HomeScreen());
    }
  }

  verifyOtp(code, type) async {
    var data = type == "email"
        ? {
            "email": emailController.text,
            "otp": code,
            "deviceToken": "none",
            "deviceType": Platform.isAndroid ? "android" : "ios"
          }
        : {
            "mobileNumber": "${countryCode}${phoneController.text}",
            "otp": code,
            "deviceToken": "none",
            "deviceType": Platform.isAndroid ? "android" : "ios"
          };
    print(data);
    var resData = await ApiProvider().post('/verify_otp', data);
    if (!resData['status']) {
      otpController.clear();

      LoaderService().showSnackbar("Message", resData['message']);
    } else {
      final storage = new FlutterSecureStorage();
      await storage.write(
          key: "localuserAuthToken", value: resData['data']['authToken']);
      await storage.write(
          key: "localuserRefreshToken", value: resData['data']['refreshToken']);
      userAuthToken = resData['data']['authToken'];
      userRefreshToken = resData['data']['refreshToken'];
      _otpTimer?.cancel();
      otpController.clear();

      if (!resData['data']['isComplete']) {
        Get.to(() => RegisterScreen());
      } else {
        Get.to(() => HomeScreen());
      }
    }
  }

  resendCode() {
    otpstart = 10;
    otpcurrent = 0;
    otptimercompleted = false;
    startTimer();
    update();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _otpTimer?.cancel();
    _otpTimer = Timer.periodic(oneSecond, (timer) {
      if (otpstart == 0) {
        timer.cancel();
        otptimercompleted = true;
      } else if (otpcurrent == 10) {
        otptimercompleted = true;
      } else {
        otpcurrent += 1;
      }
      update();
    });
  }

  registerForm() async {
    final data = {
      "firstName": firstnameController.text,
      "lastName": lastnameController.text,
      "dateOfBirth": dobController.text,
      "gender": gendarController.text,
      "bio": "None",
      "address": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "make": carnameController.text,
      "model": carmodelController.text,
      "color": carcolorController.text,
      "plateNumber": carplateController.text,
      "year": "2023",
      "about": "",
      "deviceType": Platform.isAndroid ? "android" : "ios",
      "deviceToken": "none"
    };

    if (selectedType == "email") {
      data["email"] = emailController.text;
    } else {
      data["mobileNumber"] = phoneController.text;
    }
    loadingcontroller.loadingswitch();

    var resData = await ApiProvider().post('/register', data);
    if (resData['status']) {
      loadingcontroller.loadingswitch();
      Get.offAll(HomeScreen());
      LoaderService().showSnackbar("Message", resData['message']);
    } else {
      loadingcontroller.loadingswitch();

      LoaderService().showSnackbar("Message", resData['message']);
    }
  }

  selectModel(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              bodyLarge:
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              bodyMedium:
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              bodySmall:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),
          ),
          child: AlertDialog(
            title: Text("Select Year"),
            content: Container(
              // Need to use container to add size constraint.
              width: 300,
              height: 300,
              child: YearPicker(
                firstDate: DateTime(DateTime.now().year - 100, 1),
                lastDate: DateTime(2024),
                initialDate: DateTime.now(),
                selectedDate: selectedYear,
                onChanged: (DateTime dateTime) {
                  final formattedDate = DateFormat('yyyy').format(dateTime);
                  carmodelController.text = formattedDate.toString();
                  Get.back();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1930),
      lastDate: DateTime(2024),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              bodyLarge:
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              bodyMedium:
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              bodySmall:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),
          ),
          child: child!,
        );
      },
    );

    // showDatePicker(
    //   context: context,
    //   initialDate: selectedDate,
    //   firstDate: DateTime(1930),
    //   lastDate: DateTime(2024),

    // );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      print(selectedDate);
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      dobController.text = formattedDate;
      print(formattedDate);
    }
    update();
  }
}
