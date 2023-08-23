import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Represents Homepage for Navigation
class PdfViewer extends StatefulWidget {
  final String url;
  final String pageName;
  PdfViewer({
    Key? key,
    required this.url,
    required this.pageName,
  }) : super(key: key);
  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late String url = "";
  late String pageName = "";
  final storageIO = InternetFileStorageIO();

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
        backgroundColor: Colors.white,
        title: Text(
          pageName,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(getIcon('share-network')),
            onPressed: () async {
              Future.delayed(const Duration(seconds: 1))
                  .then((value) => setState(() {}));
              SchedulerBinding.instance
                  .addPostFrameCallback((_) => showLoadingBar(context));
              print(url.toString().split("/").last);
              Directory tempDir = await getTemporaryDirectory();
              String tempPath = tempDir.path;
              print(tempPath);
              await InternetFile.get(
                url,
                progress: (receivedLength, contentLength) {
                  final percentage = receivedLength / contentLength * 100;
                  print(
                      'download progress: $receivedLength of $contentLength ($percentage%)');
                },
                storage: storageIO,
                storageAdditional: storageIO.additional(
                  filename: url.toString().split("/").last,
                  location: tempPath,
                ),
              );

              String filess = tempPath + '/' + url.toString().split("/").last;
              print(filess);
              Future.delayed(const Duration(seconds: 3)).then(
                (value) => setState(
                  () {
                    Share.shareXFiles([XFile(filess)]);
                  },
                ),
              );

              Future.delayed(const Duration(seconds: 2)).then(
                (value) => setState(
                  () {
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        url,
      ),
    );
  }
}
