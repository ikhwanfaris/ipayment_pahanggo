import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/screens/content/inbox/read_inbox.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    _onRefresh();
  }

  void _onRefresh() async {
    api.inbox.reset();
    await api.inbox.fetch();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await api.inbox.fetch();
    setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    print(state.inbox.first.createdAt);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
        title: Text('Inbox'),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: api.inbox.total > state.inbox.length,
        header: const WaterDropMaterialHeader(
          distance: 58,
        ),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text(
                'More ' +
                    (api.inbox.total - state.inbox.length).toString() +
                    ' record',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff999999),
                ),
              );
            } else if (mode == LoadStatus.loading) {
              body = const CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text(
                'Error when loading the data.',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff999999),
                ),
              );
            } else if (mode == LoadStatus.canLoading) {
              body = Text(
                'Release',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff999999),
                ),
              );
            } else {
              body = Text(
                'No more data',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff999999),
                ),
              );
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: (state.inbox.isNotEmpty)
        
            ? ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Stack(
                    children: [
                      Material(
                        color: constants.primaryColor,
                        shape: MyShapeBorder(-20),
                        child: Container(
                          height: 20,
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 0,
                        child: SizedBox(
                          height: AppBar().preferredSize.height,
                          width: MediaQuery.of(context).size.width,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  for (var item in state.inbox) ...[

                    
                  

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        onTap: () async {
                          item.isRead = true;
                          await navigate(context, ReadInbox(item));
                          await api.inbox.fetch();
                          setState(() {});
                        },
                        trailing: Icon(item.isRead
                            ? LineIcons.envelopeOpen
                            : LineIcons.envelope),
                        title: Text(
                          item.subject,
                          style: TextStyle(
                            fontWeight: item.isRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        isThreeLine: true,
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.body,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                  DateFormat('dd/MM/yyyy, hh:mm a')
                                      .format(item.createdAt.toLocal()),
                                  style: item.isRead
                                      ? styles.heading3sub
                                      : styles.heading6bold),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 2),
                  ],
                ],
              )
            : Align(
                alignment: const Alignment(0, -0.33),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/dist/aduan.svg"),
                    const SizedBox(height: 36),
                    Text(
                      'Empty Inbox'.tr,
                      style: const TextStyle(
                        color: Color(0xff121212),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your inbox will be listed here.'.tr,
                      style: const TextStyle(
                        color: Color(0xffAAAAA0),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
