import 'package:big_dog_app/features/onboarding/view/login.dart';
import 'package:big_dog_app/features/onboarding/viewmodel/authviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginSelection extends StatefulWidget {
  const LoginSelection({super.key});

  @override
  State<LoginSelection> createState() => _LoginSelectionState();
}

class _LoginSelectionState extends State<LoginSelection> {
  final controller = Get.put(AuthViewModel());

  @override
  void initState() {
    controller.checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242D3C),
      body: Center(
        child: SizedBox(
          width: 370.w,
          child: Column(
            children: [
              76.verticalSpace,
              Image.asset(
                "assets/images/logo.png",
                width: 207.w,
                height: 175.h,
              ),
              20.verticalSpace,
              Image.asset(
                "assets/images/car.png",
                width: 344.w,
                height: 228.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Pre-Login",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        )),
              ),
              17.verticalSpace,
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Select login to continue.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        )),
              ),
              17.verticalSpace,
              GestureDetector(
                onTap: () {
                  controller.selectLoginType("email");
                  // Get.to(LoginValidate());
                },
                child: btnWithIcon(context, "assets/icons/email.svg",
                    "Sign-In with Email Address"),
              ),
              10.verticalSpace,
              GestureDetector(
                onTap: () {
                  controller.selectLoginType("phone");
                },
                child: btnWithIcon(context, "assets/icons/phone.svg",
                    "Sign-In with Phone Number"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget btnWithIcon(BuildContext context, String iconPath, String buttonText) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 25.w,
            height: 25.h,
            child: SvgPicture.asset(iconPath),
          ),
          16.horizontalSpace,
          Text(
            buttonText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
