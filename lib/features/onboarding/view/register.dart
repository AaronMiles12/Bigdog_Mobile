import 'package:big_dog_app/features/onboarding/view/cardetails.dart';
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
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
                    "assets/images/logo.png",
                    width: 207.w,
                    height: 166.h,
                  ),
                  25.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Create Profile",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            )),
                  ),
                  17.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Create your profile",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            )),
                  ),
                  17.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 175.w,
                        child: RoundedTextFieldWithIcon(
                          isEnable: true,
                          hintText: 'First Name',
                          suffixIconPath: '',
                          prefixIconPath: '',
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'Required field';
                            }
                          },
                          controller: controller.firstnameController,
                        ),
                      ),
                      SizedBox(
                        width: 175.w,
                        child: RoundedTextFieldWithIcon(
                          isEnable: true,
                          hintText: 'Last Name',
                          suffixIconPath: '',
                          prefixIconPath: '',
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'Required field';
                            }
                          },
                          controller: controller.lastnameController,
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      controller.selectDOB(context);
                    },
                    child: RoundedTextFieldWithIcon(
                      isEnable: false,
                      hintText: 'Date of Birth',
                      prefixIconPath: '',
                      suffixIconPath: 'assets/icons/email.svg',
                      controller: controller.dobController,
                    ),
                  ),
                  10.verticalSpace,
                  MyDropdownWidget(
                    selectedValue: "Select gendar",
                    options: ["Select gendar", "Male", "Female"],
                    onChanged: (String) {
                      print(String);
                      controller.gendarController.text = String.toString();
                    },
                  ),
                  10.verticalSpace,
                  RoundedTextFieldWithIcon(
                    isEnable: true,
                    hintText: 'Address',
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 5) {
                        return 'Required field';
                      }
                    },
                    suffixIconPath: '',
                    prefixIconPath: '',
                    controller: controller.addressController,
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 175.w,
                        child: RoundedTextFieldWithIcon(
                          isEnable: true,
                          hintText: 'City',
                          suffixIconPath: '',
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'Required field';
                            }
                          },
                          prefixIconPath: '',
                          controller: controller.cityController,
                        ),
                      ),
                      SizedBox(
                        width: 175.w,
                        child: RoundedTextFieldWithIcon(
                          isEnable: true,
                          hintText: 'State',
                          suffixIconPath: '',
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 1) {
                              return 'Required field';
                            }
                          },
                          prefixIconPath: '',
                          controller: controller.stateController,
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  PrimaryButton(
                    onTap: () {
                      // Get.to(CarDetailsScreen());
                      if (formKey.currentState!.validate()) {
                        Get.to(CarDetailsScreen());
                      }
                    },
                    text: "Continue",
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
