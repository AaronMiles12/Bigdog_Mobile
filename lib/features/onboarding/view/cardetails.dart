import 'package:big_dog_app/features/onboarding/view/otp.dart';
import 'package:big_dog_app/features/onboarding/viewmodel/authviewmodel.dart';
import 'package:big_dog_app/widgets/customdropdown.dart';
import 'package:big_dog_app/widgets/customtextfield.dart';
import 'package:big_dog_app/widgets/primarybtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  final controller = Get.put(AuthViewModel());
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242D3C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 370.w,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/car.png",
                    width: 344.w,
                    height: 228.h,
                  ),
                  25.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Your Car Details",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            )),
                  ),
                  10.verticalSpace,
                  RoundedTextFieldWithIcon(
                    isEnable: true,
                    hintText: 'Select Car (Tesla model X)',
                    prefixIconPath: '',
                    suffixIconPath: '',
                    controller: controller.carnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Required field';
                      }
                    },
                  ),
                  10.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      controller.selectModel(context);
                    },
                    child: RoundedTextFieldWithIcon(
                      isEnable: false,
                      hintText: 'Select Model',
                      prefixIconPath: '',
                      suffixIconPath: '',
                      controller: controller.carmodelController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return 'Required field';
                        }
                      },
                    ),
                  ),
                  10.verticalSpace,
                  RoundedTextFieldWithIcon(
                    isEnable: true,
                    hintText: 'Car license plate',
                    suffixIconPath: '',
                    prefixIconPath: '',
                    controller: controller.carplateController,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 2) {
                        return 'Required field';
                      }
                    },
                  ),
                  10.verticalSpace,
                  RoundedTextFieldWithIcon(
                    isEnable: true,
                    hintText: 'Car color',
                    suffixIconPath: '',
                    prefixIconPath: '',
                    controller: controller.carcolorController,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Required field';
                      }
                    },
                  ),
                  10.verticalSpace,
                  RoundedTextFieldWithIcon(
                    isEnable: true,
                    hintText: 'Describe location',
                    suffixIconPath: '',
                    prefixIconPath: '',
                    controller: controller.caraboutController,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Required field';
                      }
                    },
                  ),
                  10.verticalSpace,
                  PrimaryButton(
                    onTap: () {
                      // Get.to(OtpScreen());
                      if (formKey.currentState!.validate()) {
                        print("asd");
                        controller.registerForm();
                      }
                    },
                    text: "Finish",
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
