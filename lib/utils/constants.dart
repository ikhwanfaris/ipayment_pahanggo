import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

const kStoreUserToken = 'token';

class AppStyles {
  TextStyle raisedButtonTextWhiteTwo =
      TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: -1);
  TextStyle raisedButtonTextWhite =
      TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 1);
  TextStyle checkoutButtonTextWhite =
      TextStyle(fontSize: 14.0, color: Colors.white, letterSpacing: 1);
  TextStyle heading1 = TextStyle(fontSize: 25, color: Colors.white);
  TextStyle heading1sub = TextStyle(fontSize: 16, color: Colors.white);
  TextStyle heading1sub2 = TextStyle(fontSize: 12, color: Colors.white);
  TextStyle heading2 = TextStyle(fontSize: 16, color: constants.eightColor);
  TextStyle heading2active =
      TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold);
  TextStyle heading2inactive =
      TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold);
  TextStyle heading2sub = TextStyle(fontSize: 16);
  TextStyle heading2white = TextStyle(fontSize: 16, color: Colors.white);
  TextStyle heading3 = TextStyle(fontSize: 16, color: constants.primaryColor);
  TextStyle heading3sub = TextStyle(fontSize: 14, color: constants.primaryColor);
  TextStyle heading3subwhite = TextStyle(fontSize: 14, color: Colors.white);

  TextStyle heading4 = TextStyle(fontSize: 16, color: Colors.white);
  TextStyle heading5 = TextStyle(fontSize: 16, color: Colors.black);
  TextStyle heading5bold =
      TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle heading6 = TextStyle(fontSize: 16, color: constants.primaryColor);
  TextStyle heading6bold = TextStyle(
      fontSize: 16, color: constants.primaryColor, fontWeight: FontWeight.bold);
  TextStyle heading6boldPaleWhite = TextStyle(
      fontSize: 16, color: constants.paleWhite, fontWeight: FontWeight.bold);
  TextStyle heading6boldAdmin = TextStyle(
      fontSize: 16, color: constants.fiveColor, fontWeight: FontWeight.bold);
  TextStyle heading6boldunderline = TextStyle(
    fontSize: 16,
    color: constants.primaryColor,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
  TextStyle heading7 = TextStyle(fontSize: 16, color: constants.sixColor);
  TextStyle heading8 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle heading8sub = TextStyle(fontSize: 14);
  TextStyle heading8subWhite = TextStyle(fontSize: 14, color: Colors.white);
  TextStyle heading9 = TextStyle(fontSize: 20);
  TextStyle heading9bold = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle heading10 = TextStyle(fontSize: 14, color: Colors.black);
  TextStyle heading10bold =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle heading10boldPrimary = TextStyle(fontSize: 14, color: constants.primaryColor, fontWeight: FontWeight.bold);
  TextStyle heading11 = TextStyle(fontSize: 12, color: Colors.black);
  TextStyle heading11bold =
      TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle heading12 = TextStyle(fontSize: 14, color: Colors.black);
  TextStyle heading12title = TextStyle(
      fontSize: 14, color: Colors.black, decoration: TextDecoration.underline);
  TextStyle heading12bold = TextStyle(
      fontSize: 16, color: constants.primaryColor, fontWeight: FontWeight.bold);
  TextStyle heading12sub = TextStyle(fontSize: 18, color: Colors.black);
  TextStyle heading12sub2 = TextStyle(fontSize: 12, color: Colors.black);
  TextStyle heading13 = TextStyle(fontSize: 18, color: constants.sixColor);
  TextStyle heading13bold =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle heading6boldYellow = TextStyle(
      fontSize: 16, color: constants.sixColor, fontWeight: FontWeight.bold);
  TextStyle heading14 = TextStyle(fontSize: 12, color: Colors.grey);
  TextStyle heading14sub = TextStyle(fontSize: 16, color: Colors.grey);
  TextStyle heading15 = TextStyle(fontSize: 16);
  TextStyle heading16 = TextStyle(fontSize: 16);
  TextStyle heading17 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle heading13Primary = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Constants().primaryColor);
  TextStyle heading13PrimarySub = TextStyle(fontSize: 14,color: Constants().primaryColor);
  TextStyle heading17white =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle heading18 = TextStyle(fontSize: 14, color: constants.eightColor);
  TextStyle heading19 = TextStyle(fontSize: 16, color: constants.sevenColor);
  TextStyle heading20 = TextStyle(
      fontSize: 14, color: constants.sevenColor, fontWeight: FontWeight.w500);
  TextStyle heading21 = TextStyle(
      fontSize: 12, color: constants.sevenColor, fontWeight: FontWeight.w400);
  TextStyle heading18grey = TextStyle(fontSize: 14);
  TextStyle errorStyle = TextStyle(fontSize: 12, color: constants.errorColor);
  TextStyle errorStyleTicket = TextStyle(fontSize: 14, color: constants.errorColor);
  TextStyle headingTitlebold = TextStyle(
      fontSize: 24, color: constants.primaryColor, fontWeight: FontWeight.bold);

  TextStyle titleHome = TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle descHome = TextStyle(fontSize: 12, color: Colors.black);
  TextStyle contentTitle = TextStyle(fontSize: 15, color: Colors.black,);

  TextStyle badgeCounterDoubleDigit = TextStyle(fontSize: 10, color: Colors.white);

  TextStyle widgetMenuCounter = TextStyle(fontSize: 16, color: constants.sixColor, fontWeight: FontWeight.bold);
  TextStyle widgetMenuCounterWhite = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle widgetMenuTitle = TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold);

  TextStyle defaultTextStyle =
      TextStyle(color: Colors.black, fontFamily: 'SfProDisplayRegular');

  TextStyle defaultInactiveTextStyle =
      TextStyle(color: Colors.redAccent, fontFamily: 'SfProDisplayRegular');

      

  static double get paddingBaseX => u1;
  static double get u1 => 4.0;
  static double get u2 => 8.0;
  static double get u3 => 12.0;
  static double get u4 => 16.0;
  static double get u5 => 20.0;
  static double get u6 => 24.0;
  static double get u7 => 28.0;
  static double get u10 => 40.0;
  static double get u11 => 44.0;
  static double get u12 => 48.0;

  static TextStyle get f3w400 =>
      TextStyle(fontSize: u3, fontWeight: FontWeight.w400);

  static TextStyle get f4w400 =>
      TextStyle(fontSize: u4, fontWeight: FontWeight.w400);

  static BoxDecoration get decoRounded => BoxDecoration(
        color: constants.green1,
        borderRadius: BorderRadius.all(Radius.circular(u4)),
      );

  InputDecoration inputDecoration = InputDecoration(
    filled: false,
    fillColor: const Color(0xffF1F3F6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Color(0xffE7EAF0)),
    ),
  );

  InputDecoration inputDecoration2 = InputDecoration(
    filled: false,
    fillColor: const Color(0xffF1F3F6),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: BorderSide(
        color: Colors.white,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: BorderSide(
        color: Colors.white,
        width: 1.0,
      ),
    ),
  );

  static InputDecoration get decoInputText => InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: u3,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(u1),
        ),
      );

  static InputDecoration get decoInputDate => AppStyles.decoInputText.copyWith(
        suffixIcon: LineIcon(
          LineIcons.calendar,
        ),
      );

  static InputDecoration get decoInputTextarea =>
      AppStyles.decoInputText.copyWith(
        contentPadding: EdgeInsets.symmetric(
          horizontal: u3,
          vertical: u2,
        ),
      );
}

var styles = AppStyles();

class Constants {
  final String appName = 'iPayment';
  final MaterialColor paleWhite = createMaterialColor(Color(0xFFFFFFFF));
  final MaterialColor errorColor = createMaterialColor(
    const Color(0XFFFC4413B),
  );

  final MaterialColor filterTicketColor = createMaterialColor(
    const Color(0XFFFEAEAEA),
  );

  final MaterialColor bgTicketColor = createMaterialColor(
    const Color(0XFFFAF9FB),
  );

  final MaterialColor widgetFourColor = createMaterialColor(
    const Color(0XFFD0E7DC),
  );

  final MaterialColor widgetThreeColor = createMaterialColor(
    const Color(0XFF1EA8AD),
  );

  final MaterialColor widgetTwoColor = createMaterialColor(
    const Color(0XFF378686),
  );

  final MaterialColor nineColor = createMaterialColor(
    const Color(0XFFFFFFFF),
  );
  final MaterialColor tenColor = createMaterialColor(
    const Color(0XFFF25A3A6),
  );
  final MaterialColor eightColor = createMaterialColor(
    const Color(0XFFF8C9791),
  );
  final MaterialColor sevenColor = createMaterialColor(
    const Color(0XFFF282B29),
  );
  final MaterialColor sixColor = createMaterialColor(
    const Color(0XFFFEBAB50),
  );
  final MaterialColor fiveColor = createMaterialColor(
    const Color(0XFFFF6C16B),
  );
  final MaterialColor fourColor = createMaterialColor(
    const Color(0XFFFD0E7DC),
  );
  final MaterialColor thirdColor = createMaterialColor(
    const Color(0XFFF33A36D),
  );
  final MaterialColor secondaryColor = createMaterialColor(
    const Color(0XFFFD5E2E1),
  );
  final MaterialColor primaryColor = createMaterialColor(
    const Color(0XFFF045B62),
  );
  final MaterialColor reverseWhiteColor = createMaterialColor(
    const Color(0xFFF5F6F9),
  );
  final MaterialColor splashColor = createMaterialColor(
    const Color(0XFFF06565D),
  );
  final MaterialColor loginText = createMaterialColor(Color(0XFF7A869A));

  final MaterialColor inputBg = createMaterialColor(Color(0XE8F5EF));

  final MaterialColor green1 = createMaterialColor(Color(0XFFD4E2DF));
  final MaterialColor green2 = createMaterialColor(Color(0XFF06565D));
}

var constants = Constants();
