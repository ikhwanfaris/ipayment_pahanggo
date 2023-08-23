import 'package:flutter/material.dart';
import 'package:flutter_file_view/flutter_file_view.dart';

/// Represents Homepage for Navigation
class XlsViewer extends StatefulWidget {
  final String url;
  final String pageName;
  XlsViewer({
    Key? key,
    required this.url,
    required this.pageName,
  }) : super(key: key);
  @override
  State<XlsViewer> createState() => _XlsViewerState();
}

class _XlsViewerState extends State<XlsViewer> {
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late String url = "";
  late String pageName = "";
  @override
  void initState() {
    FlutterFileView.init();
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
          backgroundColor: Colors.white,
          title: Text(
            pageName,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FileView(
          controller: FileViewController.network(url),
        ));
  }
}
