import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Represents Homepage for Navigation
class FaqPdfViewer extends StatefulWidget {
  final String url;
  final String pageName;
  FaqPdfViewer({
    Key? key,
    required this.url,
    required this.pageName,
  }) : super(key: key);
  @override
  State<FaqPdfViewer> createState() => _FaqPdfViewerState();
}

class _FaqPdfViewerState extends State<FaqPdfViewer> {
  late String url = "";
  late String pageName = "";

  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() {
    setState(() {
      url = widget.url;
      pageName = widget.pageName;
    });
    print(url);
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
              pageName,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: SfPdfViewer.network(
        url,
      ),
    );
  }
}
