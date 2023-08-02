import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  String code = '';
  String? path = store.getItem('registerPath');
  String? email = store.getItem('getEmailWidget');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Text(
            'Account Activation'.tr,
            style: styles.heading1sub,
          ),
        )),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Text(
                'Your registration has been successfully sent. Please refer to the email to activate your account.'
                    .tr,
                textAlign: TextAlign.justify,
                style: styles.heading5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  maskEmail(store.getItem('getEmailWidget')),
                  textAlign: TextAlign.center,
                  style: styles.heading13Primary,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              PinCodeTextField(
                autoDisposeControllers: false,
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  fieldOuterPadding: const EdgeInsets.only(left: 8, right: 8),
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(2),
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedColor: Colors.black54,
                  selectedFillColor: Colors.white,
                  inactiveColor: Colors.black54,
                  activeColor: Colors.black54,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                autoDismissKeyboard: false,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                mainAxisAlignment: MainAxisAlignment.center,
                onCompleted: (v) {
                  setState(() {
                    code = v;
                    runOTP();
                    print("Completed");
                  });
                },
                onChanged: (v) {
                  setState(() {
                    code = v;
                  });
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              Visibility(
                visible: false,
                child: TextFormField(
                  autocorrect: false,
                  textInputAction: TextInputAction.done,
                  initialValue: path,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Constants().secondaryColor,
                    enabled: true,
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'This field cannot be left blank.'.tr;
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      path = val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not received?'.tr),
                  TextButton(
                    onPressed: () async {
                      await api.resendEmailOTP(email!);
                      snack(
                          context,
                          'The new code has been successfully sent to your email. '
                                  .tr +
                              store.getItem('getEmailWidget'),
                          level: SnackLevel.Success);
                    },
                    child: Column(
                      children: [
                        Text('Resend.'.tr),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: (code.length == 5)
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.cleaning_services),
              onPressed: () {
                setState(() {
                  code = '';
                  textEditingController.text = '';
                });
              },
            ),
    );
  }

  runOTP() async {
    {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => showLoadingBar(context));
      try {
        var response = await api.verifyEmailOTP(code, path!);
        if (response.isSuccessful) {
          var loginRoute = MaterialPageRoute(builder: (_) => LoginScreen());
          setState(() {
            Navigator.pop(context);
          });
          Navigator.of(context)
              .pushAndRemoveUntil(loginRoute, (route) => false);
          hideSnacks(context);
          snack(context,
              "Account successfully activated! Please log in to proceed.".tr,
              level: SnackLevel.Success);
          return;
        }
        hideSnacks(context);
        Get.snackbar(
          snackPosition: SnackPosition.TOP,
          "".tr,
          response.message,
          messageText: Text(
            response.message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          padding: EdgeInsets.only(bottom: 30, left: 16),
          backgroundColor: Colors.red,
        );
      } catch (e) {
        snack(
            context,
            "There is a problem connecting to the server. Please try again."
                .tr);
      }
      setState(() {
        Navigator.pop(context);
      });
    }
  }
}
