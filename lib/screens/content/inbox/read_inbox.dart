import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/users/inbox.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ReadInbox extends StatefulWidget {
  final ServerInbox inbox;
  const ReadInbox(this.inbox, {Key? key}) : super(key: key);

  @override
  State<ReadInbox> createState() => _ReadInboxState();
}

class _ReadInboxState extends State<ReadInbox> {
  @override
  void initState() {
    super.initState();

    api.inbox.read(widget.inbox.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                widget.inbox.subject,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
             Text(DateFormat('dd/MM/yyyy, hh:mm a').format(widget.inbox.createdAt.toLocal()), style:  styles.heading6bold),
            const SizedBox(height: 12),
            MarkdownBody(
              data: widget.inbox.body,
              selectable: true,
              onTapLink: (link, _, __) {
                launchUrlString(link, mode: LaunchMode.externalApplication);
              },
            ),
          ],
        ),
      ),
    );
  }
}
