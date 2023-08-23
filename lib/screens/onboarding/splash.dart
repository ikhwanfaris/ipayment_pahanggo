import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/maintenance/maintenance.dart';
// import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/utils/helpers.dart';
// import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/home/menu.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;
  bool isLoading = true;
  String _token = '';
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        opacity = 1;
      });
    });

    credentialStore.ready.then((_) async {
      store.ready.then((_) async {
        await api.resume();

        setState(() {
          isLoading = false;

          _token = store.getItem(kStoreUserToken).toString();

          if (_token != 'null') {
            isLoggedIn = true;
          } else {
            isLoggedIn = false;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/dist/bg_laucher.png'),
          ),
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          opacity: opacity,
          onEnd: () async {
            if (opacity == 1) {
              await Future(() => !isLoading);
              await Future.delayed(const Duration(seconds: 1));
              setState(() {
                opacity = 0;
              });
            } else {
              loadApp(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/dist/Plus.svg',
                        height: MediaQuery.of(context).size.width / 7,
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          "iPayment",
                          style: styles.heading4,
                        ),
                      ),
                      SizedBox(height: 180),
                      DefaultLoadingBar(),
                    ],
                  ),
                ),
                Text(
                  "By:".tr,
                  style: styles.heading4,
                ),
                SizedBox(height: 12),
                Text(
                  "Accounting Department of Malaysia".tr,
                  style: styles.heading4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadApp(BuildContext context) async {
    try {
      var response = await api.resume();

      if (response.isSuccessful) {
        var nextRoute = MaterialPageRoute(builder: (_) => MenuScreen());
        snack(context, 'Welcome back '.tr + state.user.firstName! + '!',
            level: SnackLevel.Success);

        Navigator.of(context).pushReplacement(nextRoute);

        return;
      } else {
        if (response.statusCode == 503) {
          navigate(context, MaintenanceScreen());
        } else if (isLoggedIn) {
          var nextRoute = MaterialPageRoute(builder: (_) => MenuScreen());
          snack(context, 'Welcome back '.tr + state.user.firstName! + '!',
              level: SnackLevel.Success);

          Navigator.of(context).pushReplacement(nextRoute);
        } else {
          navigate(context, LoginScreen());
        }
      }
    } catch (e) {
      print(e);
      snack(context,
          "There is a problem connecting to the server. Please try again.".tr);
    }
  }
}
