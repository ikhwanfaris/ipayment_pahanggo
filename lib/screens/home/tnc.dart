import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/users/tnc.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class TncScreen extends StatefulWidget {
  const TncScreen({Key? key}) : super(key: key);

  @override
  State<TncScreen> createState() => _TncScreenState();
}

class _TncScreenState extends State<TncScreen> {
  List<Tnc> _tncModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _tncModel = await api.getConfigTnc();
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left:55),
            child: Text(
              "Terms and Conditions".tr,
              style: styles.heading1sub,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(LineIcons.times, color: Colors.white),
          ),
        ],
          iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _tncModel.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: MarkdownBody(
                      shrinkWrap: true,
                      data: _tncModel[index].content.toString(),
                    ),
                  );
                })),
      ),
    );
  }
}
