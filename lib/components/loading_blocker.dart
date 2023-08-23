
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';

class LoadingBlockerController {
  final RxBool isLoading = false.obs;

  show() {
    isLoading.value = true;
  }

  hide() {
    isLoading.value = false;
  }

  void bind(RxBool boundValue) {
    Future.delayed(Duration(milliseconds: 1))
      .then((_){
        if(boundValue.value)
          show();
        debounce(boundValue, (bool value) {
          if(!value) {
            hide();
          } else {
            show();
          }
        }, time: Duration(milliseconds: 1));
      });
  }
}

class LoadingBlocker extends StatelessWidget {
  final Widget child;

  LoadingBlocker({required this.child});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          child,
          Obx(() => loadingBlocker.isLoading.value ? Container(
            color: Colors.black45,
            child: Center(
              child: DefaultLoadingBar(),
            ),
          ) : SizedBox()),
        ],
    ));
  }
}

var loadingBlocker = LoadingBlockerController();
