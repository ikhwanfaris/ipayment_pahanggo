import 'package:flutter/material.dart'
    hide RefreshIndicatorState, RefreshIndicator;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';


class MyEnRefreshString implements RefreshString {
  @override
  String? canLoadingText = "Release to load more.";

  @override
  String? canRefreshText = "Release to refresh.";

  @override
  String? canTwoLevelText = "Release to enter secondfloor.";

  @override
  String? idleLoadingText = "Pull up Load more.";

  @override
  String? idleRefreshText = "Pull down Refresh.";

  @override
  String? loadFailedText = "Load Failed.";

  @override
  String? loadingText = "Loading…";

  @override
  String? noMoreText = "No more data.";

  @override
  String? refreshCompleteText = "Refresh completed.";

  @override
  String? refreshFailedText = "Refresh failed.";

  @override
  String? refreshingText = "Refreshing…";
}

class MyRefreshString implements RefreshString {
  @override
  String? canLoadingText = "Lepaskan untuk load data lagi.";

  @override
  String? canRefreshText = "Lepaskan untuk refresh.";

  @override
  String? canTwoLevelText = "Lepaskan untuk enter secondfloor.";

  @override
  String? idleLoadingText = "Tarik ke atas untuk load lagi.";

  @override
  String? idleRefreshText = "Tarik untuk refresh.";

  @override
  String? loadFailedText = "Load tidak berjaya.";

  @override
  String? loadingText = "Sedang load…";

  @override
  String? noMoreText = "Tiada lagi data.";

  @override
  String? refreshCompleteText = "Refresh selesai.";

  @override
  String? refreshFailedText = "Ralat semasa refresh.";

  @override
  String? refreshingText = "Sedang refresh…";
}

/// QQ ios refresh  header effect
class MyWaterDropHeader extends RefreshIndicator {
  /// refreshing content
  final Widget? refresh;

  /// complete content
  final Widget? complete;

  /// failed content
  final Widget? failed;

  /// idle Icon center in waterCircle
  final Widget idleIcon;

  /// waterDrop color,default grey
  final Color waterDropColor;

  const MyWaterDropHeader({
    Key? key,
    this.refresh,
    this.complete,
    Duration completeDuration = const Duration(milliseconds: 600),
    this.failed,
    this.waterDropColor = Colors.grey,
    this.idleIcon = const Icon(
      Icons.autorenew,
      size: 15,
      color: Colors.white,
    ),
  }) : super(
            key: key,
            height: 60.0,
            completeDuration: completeDuration,
            refreshStyle: RefreshStyle.UnFollow);

  @override
  State<StatefulWidget> createState() {
    return _MyWaterDropHeaderState();
  }
}

class _MyWaterDropHeaderState extends RefreshIndicatorState<MyWaterDropHeader>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  late AnimationController _dismissCtl;

  RefreshString get getRefreshStrings {
    String lang = Get.locale?.languageCode ?? 'en';
    return lang == 'ms_MY' ? MyRefreshString() : MyEnRefreshString();
  }

  @override
  void onOffsetChange(double offset) {
    final double realOffset =
        offset - 44.0; //55.0 mean circleHeight(24) + originH (20) in Painter
    // when readyTorefresh
    if (!_animationController!.isAnimating)
      _animationController!.value = realOffset;
  }

  @override
  Future<void> readyToRefresh() {
    _dismissCtl.animateTo(0.0);
    return _animationController!.animateTo(0.0);
  }

  @override
  void initState() {
    _dismissCtl = AnimationController(
        vsync: this, duration: Duration(milliseconds: 400), value: 1.0);
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 50.0,
        duration: Duration(milliseconds: 400));
    super.initState();
  }

  @override
  bool needReverseAll() {
    return false;
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus? mode) {
    Widget? child;
    if (mode == RefreshStatus.refreshing) {
      child = widget.refresh ??
          SizedBox(
            width: 25.0,
            height: 25.0,
            child: defaultTargetPlatform == TargetPlatform.iOS
                ? const CupertinoActivityIndicator()
                : const CircularProgressIndicator(strokeWidth: 2.0),
          );
    } else if (mode == RefreshStatus.completed) {
      child = widget.complete ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.done,
                color: Colors.grey,
              ),
              Container(
                width: 15.0,
              ),
              Text(
                getRefreshStrings
                    .refreshCompleteText!,
                style: TextStyle(color: Colors.grey),
              )
            ],
          );
    } else if (mode == RefreshStatus.failed) {
      child = widget.failed ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.close,
                color: Colors.grey,
              ),
              Container(
                width: 15.0,
              ),
              Text(
                  getRefreshStrings
                      .refreshFailedText!,
                  style: TextStyle(color: Colors.grey))
            ],
          );
    } else if (mode == RefreshStatus.idle || mode == RefreshStatus.canRefresh) {
      return FadeTransition(
          child: Container(
            child: Stack(
              children: <Widget>[
                RotatedBox(
                  child: CustomPaint(
                    child: Container(
                      height: 60.0,
                    ),
                    painter: _QqPainter(
                      color: widget.waterDropColor,
                      listener: _animationController,
                    ),
                  ),
                  quarterTurns:
                      Scrollable.of(context).axisDirection == AxisDirection.up
                          ? 10
                          : 0,
                ),
                Container(
                  alignment:
                      Scrollable.of(context).axisDirection == AxisDirection.up
                          ? Alignment.bottomCenter
                          : Alignment.topCenter,
                  margin:
                      Scrollable.of(context).axisDirection == AxisDirection.up
                          ? EdgeInsets.only(bottom: 12.0)
                          : EdgeInsets.only(top: 12.0),
                  child: widget.idleIcon,
                )
              ],
            ),
            height: 60.0,
          ),
          opacity: _dismissCtl);
    }
    return Container(
      height: 60.0,
      child: Center(
        child: child,
      ),
    );
  }

  @override
  void resetValue() {
    _animationController!.reset();
    _dismissCtl.value = 1.0;
  }

  @override
  void dispose() {
    _dismissCtl.dispose();
    _animationController!.dispose();
    super.dispose();
  }
}

class _QqPainter extends CustomPainter {
  final Color? color;
  final Animation<double>? listener;

  double get value => listener!.value;
  final Paint painter = Paint();

  _QqPainter({this.color, this.listener}) : super(repaint: listener);

  @override
  void paint(Canvas canvas, Size size) {
    final double originH = 20.0;
    final double middleW = size.width / 2;

    final double circleSize = 12.0;

    final double scaleRatio = 0.1;

    final double offset = value;

    painter.color = color!;
    canvas.drawCircle(Offset(middleW, originH), circleSize, painter);
    Path path = Path();
    path.moveTo(middleW - circleSize, originH);

    //drawleft
    path.cubicTo(
        middleW - circleSize,
        originH,
        middleW - circleSize + value * scaleRatio,
        originH + offset / 5,
        middleW - circleSize + value * scaleRatio * 2,
        originH + offset);
    path.lineTo(
        middleW + circleSize - value * scaleRatio * 2, originH + offset);
    //draw right
    path.cubicTo(
        middleW + circleSize - value * scaleRatio * 2,
        originH + offset,
        middleW + circleSize - value * scaleRatio,
        originH + offset / 5,
        middleW + circleSize,
        originH);
    //draw upper circle
    path.moveTo(middleW - circleSize, originH);
    path.arcToPoint(Offset(middleW + circleSize, originH),
        radius: Radius.circular(circleSize));

    //draw lowwer circle
    path.moveTo(
        middleW + circleSize - value * scaleRatio * 2, originH + offset);
    path.arcToPoint(
        Offset(middleW - circleSize + value * scaleRatio * 2, originH + offset),
        radius: Radius.circular(value * scaleRatio));
    path.close();
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}


class MyClassicFooter extends LoadIndicator {
  final String? idleText, loadingText, noDataText, failedText, canLoadingText;

  /// a builder for re wrap child,If you need to change the boxExtent or background,padding etc.you need outerBuilder to reWrap child
  /// example:
  /// ```dart
  /// outerBuilder:(child){
  ///    return Container(
  ///       color:Colors.red,
  ///       child:child
  ///    );
  /// }
  /// ````
  /// In this example,it will help to add backgroundColor in indicator
  final OuterBuilder? outerBuilder;

  final Widget? idleIcon, loadingIcon, noMoreIcon, failedIcon, canLoadingIcon;

  /// icon and text middle margin
  final double spacing;

  final IconPosition iconPos;

  final TextStyle textStyle;

  /// notice that ,this attrs only works for LoadStyle.ShowWhenLoading
  final Duration completeDuration;

  const MyClassicFooter({
    Key? key,
    VoidCallback? onClick,
    LoadStyle loadStyle = LoadStyle.ShowAlways,
    double height = 60.0,
    this.outerBuilder,
    this.textStyle = const TextStyle(color: Colors.grey),
    this.loadingText,
    this.noDataText,
    this.noMoreIcon,
    this.idleText,
    this.failedText,
    this.canLoadingText,
    this.failedIcon = const Icon(Icons.error, color: Colors.grey),
    this.iconPos = IconPosition.left,
    this.spacing = 15.0,
    this.completeDuration = const Duration(milliseconds: 300),
    this.loadingIcon,
    this.canLoadingIcon = const Icon(Icons.autorenew, color: Colors.grey),
    this.idleIcon = const Icon(Icons.arrow_upward, color: Colors.grey),
  }) : super(
          key: key,
          loadStyle: loadStyle,
          height: height,
          onClick: onClick,
        );

  @override
  State<StatefulWidget> createState() {
    return _MyClassicFooterState();
  }
}

class _MyClassicFooterState extends LoadIndicatorState<MyClassicFooter> {

  RefreshString get getRefreshStrings {
    String lang = Get.locale?.languageCode ?? 'en';
    return lang == 'ms_MY' ? MyRefreshString() : MyEnRefreshString();
  }

  Widget _buildText(LoadStatus? mode) {
    return Text(
        mode == LoadStatus.loading
            ? widget.loadingText ?? getRefreshStrings.loadingText!
            : LoadStatus.noMore == mode
                ? widget.noDataText ?? getRefreshStrings.noMoreText!
                : LoadStatus.failed == mode
                    ? widget.failedText ?? getRefreshStrings.loadFailedText!
                    : LoadStatus.canLoading == mode
                        ? widget.canLoadingText ?? getRefreshStrings.canLoadingText!
                        : widget.idleText ?? getRefreshStrings.idleLoadingText!,
        style: widget.textStyle);
  }

  Widget _buildIcon(LoadStatus? mode) {
    Widget? icon = mode == LoadStatus.loading
        ? widget.loadingIcon ??
            SizedBox(
              width: 25.0,
              height: 25.0,
              child: defaultTargetPlatform == TargetPlatform.iOS
                  ? const CupertinoActivityIndicator()
                  : const CircularProgressIndicator(strokeWidth: 2.0),
            )
        : mode == LoadStatus.noMore
            ? widget.noMoreIcon
            : mode == LoadStatus.failed
                ? widget.failedIcon
                : mode == LoadStatus.canLoading
                    ? widget.canLoadingIcon
                    : widget.idleIcon;
    return icon ?? Container();
  }

  @override
  Future endLoading() {
    return Future.delayed(widget.completeDuration);
  }

  @override
  Widget buildContent(BuildContext context, LoadStatus? mode) {
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);
    List<Widget> children = <Widget>[iconWidget, textWidget];
    final Widget container = Wrap(
      spacing: widget.spacing,
      textDirection: widget.iconPos == IconPosition.left
          ? TextDirection.ltr
          : TextDirection.rtl,
      direction: widget.iconPos == IconPosition.bottom ||
              widget.iconPos == IconPosition.top
          ? Axis.vertical
          : Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      verticalDirection: widget.iconPos == IconPosition.bottom
          ? VerticalDirection.up
          : VerticalDirection.down,
      alignment: WrapAlignment.center,
      children: children,
    );
    return widget.outerBuilder != null
        ? widget.outerBuilder!(container)
        : Container(
            height: widget.height,
            child: Center(
              child: container,
            ),
          );
  }
}