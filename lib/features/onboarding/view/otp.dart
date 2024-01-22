import 'package:big_dog_app/features/onboarding/view/register.dart';
import 'package:big_dog_app/features/onboarding/viewmodel/authviewmodel.dart';
import 'package:big_dog_app/widgets/customtextfield.dart';
import 'package:big_dog_app/widgets/primarybtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final type;
  const OtpScreen({super.key, required this.type});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = Get.put(AuthViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.startTimer();
  }

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
                48.verticalSpace,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Verification",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          )),
                ),
                17.verticalSpace,
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 323.w,
                    child: Text(
                        "We have sent you an email containing 6 digits verification code. Please enter the code to verify your identity",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            )),
                  ),
                ),
                17.verticalSpace,
                SizedBox(
                  width: 382.w,
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: controller.otpController,
                    onCompleted: (_) {
                      print(_);
                      controller.verifyOtp(_, widget.type);
                      // Get.to(RegisterScreen());
                    },
                    onChanged: (value) {
                      // Check if the OTP field is filled, then move to the next field
                      // if (value.length == widget.length) {
                      //   FocusScope.of(context).nextFocus();
                      // }
                    },
                    enableActiveFill: true,
                    textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w300),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      disabledColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      activeFillColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      selectedFillColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      selectedColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      inactiveFillColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      borderWidth: 1,
                      fieldHeight: 70.h,
                      fieldWidth: 58.w,
                      inactiveColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      activeColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ),
                // 20.verticalSpace,
                // GetBuilder<AuthViewModel>(
                //     builder: (_) => !controller.otptimercompleted
                //         ? ClipRRect(
                //             borderRadius: BorderRadius.circular(100),
                //             child: CircularPercentIndicator(
                //               radius: 90.w,
                //               lineWidth: 12,
                //               percent: controller.otptimercompleted
                //                   ? 1.0
                //                   : controller.otpcurrent / controller.otpstart,
                //               center: Text(
                //                 controller.otptimercompleted
                //                     ? 'Timer Completed'
                //                     : '${controller.otpcurrent} s',
                //                 style: const TextStyle(
                //                   fontSize: 24.0,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               progressColor: Colors.white,
                //               fillColor: Theme.of(context).colorScheme.secondary,
                //             ),
                //           )
                //         : GestureDetector(
                //             onTap: () {
                //               controller.resendCode();
                //             },
                //             child: RichText(
                //                 text: TextSpan(
                //               style: TextStyle(
                //                 fontSize: 14.0,
                //                 color: Colors.black,
                //               ),
                //               children: <TextSpan>[
                //                 TextSpan(
                //                     text: "Code Didn't Receive? ",
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .bodyMedium!
                //                         .copyWith(color: Colors.white)),
                //                 TextSpan(
                //                     text: 'Resend',
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .bodyMedium!
                //                         .copyWith(
                //                             color: Theme.of(context)
                //                                 .colorScheme
                //                                 .secondary)),
                //               ],
                //             )),
                //           )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
