import 'package:big_dog_app/features/onboarding/view/otp.dart';
import 'package:big_dog_app/features/onboarding/viewmodel/authviewmodel.dart';
import 'package:big_dog_app/widgets/customtextfield.dart';
import 'package:big_dog_app/widgets/primarybtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class LoginValidate extends StatefulWidget {
  final logintype;
  const LoginValidate({super.key, required this.logintype});

  @override
  State<LoginValidate> createState() => _LoginValidateState();
}

class _LoginValidateState extends State<LoginValidate> {
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthViewModel());

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
        child: SingleChildScrollView(
          child: SizedBox(
            width: 370.w,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 207.w,
                  height: 166.h,
                ),
                Image.asset(
                  "assets/images/car.png",
                  width: 344.w,
                  height: 228.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Login",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          )),
                ),
                17.verticalSpace,
                widget.logintype == "email"
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Enter your email address",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                )),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Enter your phone number",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                )),
                      ),
                17.verticalSpace,
                widget.logintype == "email"
                    ? RoundedTextFieldWithIcon(
                        isEnable: true,
                        hintText: 'email@gmail.com',
                        prefixIconPath: 'assets/icons/email.svg',
                        suffixIconPath: '',
                        controller: controller.emailController,
                      )
                    : Theme(
                        data: Theme.of(context).copyWith(
                          textTheme: TextTheme(
                            bodyLarge: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                            bodyMedium: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                            bodySmall: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                        child: IntlPhoneField(
                          controller: controller.phoneController,
                          focusNode: focusNode,
                          dropdownIconPosition: IconPosition.trailing,
                          showDropdownIcon: false,
                          cursorColor: Colors.white,
                          dropdownTextStyle: TextStyle(color: Colors.white),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            fillColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            filled: true,
                            hintMaxLines: 0,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 21.h, horizontal: 13.w),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          languageCode: "en",
                          onChanged: (phone) {
                            controller.countryCode =
                                phone.countryCode.toString();
                            print(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            print('Country changed to: ' + country.name);
                          },
                        ),
                      ),
                // : RoundedTextFieldWithIcon(
                //     isEnable: true,
                //     hintText: '+1 (xxx) xxxx',
                //     prefixIconPath: 'assets/icons/email.svg',
                //     suffixIconPath: '',
                //     controller: controller.phoneController,
                //   ),
                20.verticalSpace,
                PrimaryButton(
                  onTap: () {
                    controller.checkLoginValidation(widget.logintype);
                  },
                  text: "Continue",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
