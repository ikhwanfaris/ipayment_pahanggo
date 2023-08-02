import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/users/user_manual.dart';
import 'package:flutterbase/screens/content/profile/my_profile/faq_pdf_viewer.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

/// Represents Homepage for Navigation
class LinkUserManualScreen extends StatefulWidget {
  @override
  State<LinkUserManualScreen> createState() => _LinkUserManualScreenState();
}

class _LinkUserManualScreenState extends State<LinkUserManualScreen> {
  List<UserManual> _userManualModel = [];

  String endpoint = ENDPOINT;

  @override
  void initState() {
    super.initState();

    _getData();
  }

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _userManualModel = await api.getUserManual();
    setState(() {
      _userManualModel = _userManualModel;
    });

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              LineIcons.angleLeft,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 55),
              child: Text(
                'User Manual'.tr,
                style: styles.heading1sub,
              ),
            ),
          ),
        ),
        body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _userManualModel.length,
        itemBuilder: (context, index) {
          return Card(
            color: constants.secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('${index + 1}.', style: styles.heading10bold),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                        onTap: () =>                   
                        navigate(
                              context,
                              FaqPdfViewer(
                                url: endpoint +
                                    '/storage/' +
                                    _userManualModel[index].filePath.toString(),
                                pageName: "Attachment".tr,
                              ),
                            ),
                        child: Text(
                          _userManualModel[index].name.toString(),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
