import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

IconData getIcon(String name) {
  if (name.indexOf('ph-') == 0) {
    name = name.substring(3);
  }

  // Convert hyphen-separated words to camelCase
  name = name.replaceAllMapped(
      RegExp(r'-(\w)'), (match) => match.group(1)!.toUpperCase());

  switch (name) {
    case 'addressBook':
      return PhosphorIcons.regular.addressBook;

    case 'airTrafficControl':
      return PhosphorIcons.regular.airTrafficControl;

    case 'airplane':
      return PhosphorIcons.regular.airplane;

    case 'airplaneInFlight':
      return PhosphorIcons.regular.airplaneInFlight;

    case 'airplaneLanding':
      return PhosphorIcons.regular.airplaneLanding;

    case 'airplaneTakeoff':
      return PhosphorIcons.regular.airplaneTakeoff;

    case 'airplaneTilt':
      return PhosphorIcons.regular.airplaneTilt;

    case 'airplay':
      return PhosphorIcons.regular.airplay;

    case 'alarm':
      return PhosphorIcons.regular.alarm;

    case 'alien':
      return PhosphorIcons.regular.alien;

    case 'alignBottom':
      return PhosphorIcons.regular.alignBottom;

    case 'alignBottomSimple':
      return PhosphorIcons.regular.alignBottomSimple;

    case 'alignCenterHorizontal':
      return PhosphorIcons.regular.alignCenterHorizontal;

    case 'alignCenterHorizontalSimple':
      return PhosphorIcons.regular.alignCenterHorizontalSimple;

    case 'alignCenterVertical':
      return PhosphorIcons.regular.alignCenterVertical;

    case 'alignCenterVerticalSimple':
      return PhosphorIcons.regular.alignCenterVerticalSimple;

    case 'alignLeft':
      return PhosphorIcons.regular.alignLeft;

    case 'alignLeftSimple':
      return PhosphorIcons.regular.alignLeftSimple;

    case 'alignRight':
      return PhosphorIcons.regular.alignRight;

    case 'alignRightSimple':
      return PhosphorIcons.regular.alignRightSimple;

    case 'alignTop':
      return PhosphorIcons.regular.alignTop;

    case 'alignTopSimple':
      return PhosphorIcons.regular.alignTopSimple;

    case 'amazonLogo':
      return PhosphorIcons.regular.amazonLogo;

    case 'anchor':
      return PhosphorIcons.regular.anchor;

    case 'anchorSimple':
      return PhosphorIcons.regular.anchorSimple;

    case 'androidLogo':
      return PhosphorIcons.regular.androidLogo;

    case 'angularLogo':
      return PhosphorIcons.regular.angularLogo;

    case 'aperture':
      return PhosphorIcons.regular.aperture;

    case 'appStoreLogo':
      return PhosphorIcons.regular.appStoreLogo;

    case 'appWindow':
      return PhosphorIcons.regular.appWindow;

    case 'appleLogo':
      return PhosphorIcons.regular.appleLogo;

    case 'applePodcastsLogo':
      return PhosphorIcons.regular.applePodcastsLogo;

    case 'archive':
      return PhosphorIcons.regular.archive;

    case 'archiveBox':
      return PhosphorIcons.regular.archiveBox;

    case 'archiveTray':
      return PhosphorIcons.regular.archiveTray;

    case 'armchair':
      return PhosphorIcons.regular.armchair;

    case 'arrowArcLeft':
      return PhosphorIcons.regular.arrowArcLeft;

    case 'arrowArcRight':
      return PhosphorIcons.regular.arrowArcRight;

    case 'arrowBendDoubleUpLeft':
      return PhosphorIcons.regular.arrowBendDoubleUpLeft;

    case 'arrowBendDoubleUpRight':
      return PhosphorIcons.regular.arrowBendDoubleUpRight;

    case 'arrowBendDownLeft':
      return PhosphorIcons.regular.arrowBendDownLeft;

    case 'arrowBendDownRight':
      return PhosphorIcons.regular.arrowBendDownRight;

    case 'arrowBendLeftDown':
      return PhosphorIcons.regular.arrowBendLeftDown;

    case 'arrowBendLeftUp':
      return PhosphorIcons.regular.arrowBendLeftUp;

    case 'arrowBendRightDown':
      return PhosphorIcons.regular.arrowBendRightDown;

    case 'arrowBendRightUp':
      return PhosphorIcons.regular.arrowBendRightUp;

    case 'arrowBendUpLeft':
      return PhosphorIcons.regular.arrowBendUpLeft;

    case 'arrowBendUpRight':
      return PhosphorIcons.regular.arrowBendUpRight;

    case 'arrowCircleDown':
      return PhosphorIcons.regular.arrowCircleDown;

    case 'arrowCircleDownLeft':
      return PhosphorIcons.regular.arrowCircleDownLeft;

    case 'arrowCircleDownRight':
      return PhosphorIcons.regular.arrowCircleDownRight;

    case 'arrowCircleLeft':
      return PhosphorIcons.regular.arrowCircleLeft;

    case 'arrowCircleRight':
      return PhosphorIcons.regular.arrowCircleRight;

    case 'arrowCircleUp':
      return PhosphorIcons.regular.arrowCircleUp;

    case 'arrowCircleUpLeft':
      return PhosphorIcons.regular.arrowCircleUpLeft;

    case 'arrowCircleUpRight':
      return PhosphorIcons.regular.arrowCircleUpRight;

    case 'arrowClockwise':
      return PhosphorIcons.regular.arrowClockwise;

    case 'arrowCounterClockwise':
      return PhosphorIcons.regular.arrowCounterClockwise;

    case 'arrowDown':
      return PhosphorIcons.regular.arrowDown;

    case 'arrowDownLeft':
      return PhosphorIcons.regular.arrowDownLeft;

    case 'arrowDownRight':
      return PhosphorIcons.regular.arrowDownRight;

    case 'arrowElbowDownLeft':
      return PhosphorIcons.regular.arrowElbowDownLeft;

    case 'arrowElbowDownRight':
      return PhosphorIcons.regular.arrowElbowDownRight;

    case 'arrowElbowLeft':
      return PhosphorIcons.regular.arrowElbowLeft;

    case 'arrowElbowLeftDown':
      return PhosphorIcons.regular.arrowElbowLeftDown;

    case 'arrowElbowLeftUp':
      return PhosphorIcons.regular.arrowElbowLeftUp;

    case 'arrowElbowRight':
      return PhosphorIcons.regular.arrowElbowRight;

    case 'arrowElbowRightDown':
      return PhosphorIcons.regular.arrowElbowRightDown;

    case 'arrowElbowRightUp':
      return PhosphorIcons.regular.arrowElbowRightUp;

    case 'arrowElbowUpLeft':
      return PhosphorIcons.regular.arrowElbowUpLeft;

    case 'arrowElbowUpRight':
      return PhosphorIcons.regular.arrowElbowUpRight;

    case 'arrowFatDown':
      return PhosphorIcons.regular.arrowFatDown;

    case 'arrowFatLeft':
      return PhosphorIcons.regular.arrowFatLeft;

    case 'arrowFatLineDown':
      return PhosphorIcons.regular.arrowFatLineDown;

    case 'arrowFatLineLeft':
      return PhosphorIcons.regular.arrowFatLineLeft;

    case 'arrowFatLineRight':
      return PhosphorIcons.regular.arrowFatLineRight;

    case 'arrowFatLineUp':
      return PhosphorIcons.regular.arrowFatLineUp;

    case 'arrowFatLinesDown':
      return PhosphorIcons.regular.arrowFatLinesDown;

    case 'arrowFatLinesLeft':
      return PhosphorIcons.regular.arrowFatLinesLeft;

    case 'arrowFatLinesRight':
      return PhosphorIcons.regular.arrowFatLinesRight;

    case 'arrowFatLinesUp':
      return PhosphorIcons.regular.arrowFatLinesUp;

    case 'arrowFatRight':
      return PhosphorIcons.regular.arrowFatRight;

    case 'arrowFatUp':
      return PhosphorIcons.regular.arrowFatUp;

    case 'arrowLeft':
      return PhosphorIcons.regular.arrowLeft;

    case 'arrowLineDown':
      return PhosphorIcons.regular.arrowLineDown;

    case 'arrowLineDownLeft':
      return PhosphorIcons.regular.arrowLineDownLeft;

    case 'arrowLineDownRight':
      return PhosphorIcons.regular.arrowLineDownRight;

    case 'arrowLineLeft':
      return PhosphorIcons.regular.arrowLineLeft;

    case 'arrowLineRight':
      return PhosphorIcons.regular.arrowLineRight;

    case 'arrowLineUp':
      return PhosphorIcons.regular.arrowLineUp;

    case 'arrowLineUpLeft':
      return PhosphorIcons.regular.arrowLineUpLeft;

    case 'arrowLineUpRight':
      return PhosphorIcons.regular.arrowLineUpRight;

    case 'arrowRight':
      return PhosphorIcons.regular.arrowRight;

    case 'arrowSquareDown':
      return PhosphorIcons.regular.arrowSquareDown;

    case 'arrowSquareDownLeft':
      return PhosphorIcons.regular.arrowSquareDownLeft;

    case 'arrowSquareDownRight':
      return PhosphorIcons.regular.arrowSquareDownRight;

    case 'arrowSquareIn':
      return PhosphorIcons.regular.arrowSquareIn;

    case 'arrowSquareLeft':
      return PhosphorIcons.regular.arrowSquareLeft;

    case 'arrowSquareOut':
      return PhosphorIcons.regular.arrowSquareOut;

    case 'arrowSquareRight':
      return PhosphorIcons.regular.arrowSquareRight;

    case 'arrowSquareUp':
      return PhosphorIcons.regular.arrowSquareUp;

    case 'arrowSquareUpLeft':
      return PhosphorIcons.regular.arrowSquareUpLeft;

    case 'arrowSquareUpRight':
      return PhosphorIcons.regular.arrowSquareUpRight;

    case 'arrowUDownLeft':
      return PhosphorIcons.regular.arrowUDownLeft;

    case 'arrowUDownRight':
      return PhosphorIcons.regular.arrowUDownRight;

    case 'arrowULeftDown':
      return PhosphorIcons.regular.arrowULeftDown;

    case 'arrowULeftUp':
      return PhosphorIcons.regular.arrowULeftUp;

    case 'arrowURightDown':
      return PhosphorIcons.regular.arrowURightDown;

    case 'arrowURightUp':
      return PhosphorIcons.regular.arrowURightUp;

    case 'arrowUUpLeft':
      return PhosphorIcons.regular.arrowUUpLeft;

    case 'arrowUUpRight':
      return PhosphorIcons.regular.arrowUUpRight;

    case 'arrowUp':
      return PhosphorIcons.regular.arrowUp;

    case 'arrowUpLeft':
      return PhosphorIcons.regular.arrowUpLeft;

    case 'arrowUpRight':
      return PhosphorIcons.regular.arrowUpRight;

    case 'arrowsClockwise':
      return PhosphorIcons.regular.arrowsClockwise;

    case 'arrowsCounterClockwise':
      return PhosphorIcons.regular.arrowsCounterClockwise;

    case 'arrowsDownUp':
      return PhosphorIcons.regular.arrowsDownUp;

    case 'arrowsHorizontal':
      return PhosphorIcons.regular.arrowsHorizontal;

    case 'arrowsIn':
      return PhosphorIcons.regular.arrowsIn;

    case 'arrowsInCardinal':
      return PhosphorIcons.regular.arrowsInCardinal;

    case 'arrowsInLineHorizontal':
      return PhosphorIcons.regular.arrowsInLineHorizontal;

    case 'arrowsInLineVertical':
      return PhosphorIcons.regular.arrowsInLineVertical;

    case 'arrowsInSimple':
      return PhosphorIcons.regular.arrowsInSimple;

    case 'arrowsLeftRight':
      return PhosphorIcons.regular.arrowsLeftRight;

    case 'arrowsMerge':
      return PhosphorIcons.regular.arrowsMerge;

    case 'arrowsOut':
      return PhosphorIcons.regular.arrowsOut;

    case 'arrowsOutCardinal':
      return PhosphorIcons.regular.arrowsOutCardinal;

    case 'arrowsOutLineHorizontal':
      return PhosphorIcons.regular.arrowsOutLineHorizontal;

    case 'arrowsOutLineVertical':
      return PhosphorIcons.regular.arrowsOutLineVertical;

    case 'arrowsOutSimple':
      return PhosphorIcons.regular.arrowsOutSimple;

    case 'arrowsSplit':
      return PhosphorIcons.regular.arrowsSplit;

    case 'arrowsVertical':
      return PhosphorIcons.regular.arrowsVertical;

    case 'article':
      return PhosphorIcons.regular.article;

    case 'articleMedium':
      return PhosphorIcons.regular.articleMedium;

    case 'articleNyTimes':
      return PhosphorIcons.regular.articleNyTimes;

    case 'asterisk':
      return PhosphorIcons.regular.asterisk;

    case 'asteriskSimple':
      return PhosphorIcons.regular.asteriskSimple;

    case 'at':
      return PhosphorIcons.regular.at;

    case 'atom':
      return PhosphorIcons.regular.atom;

    case 'baby':
      return PhosphorIcons.regular.baby;

    case 'backpack':
      return PhosphorIcons.regular.backpack;

    case 'backspace':
      return PhosphorIcons.regular.backspace;

    case 'bag':
      return PhosphorIcons.regular.bag;

    case 'bagSimple':
      return PhosphorIcons.regular.bagSimple;

    case 'balloon':
      return PhosphorIcons.regular.balloon;

    case 'bandaids':
      return PhosphorIcons.regular.bandaids;

    case 'bank':
      return PhosphorIcons.regular.bank;

    case 'barbell':
      return PhosphorIcons.regular.barbell;

    case 'barcode':
      return PhosphorIcons.regular.barcode;

    case 'barricade':
      return PhosphorIcons.regular.barricade;

    case 'baseball':
      return PhosphorIcons.regular.baseball;

    case 'baseballCap':
      return PhosphorIcons.regular.baseballCap;

    case 'basket':
      return PhosphorIcons.regular.basket;

    case 'basketball':
      return PhosphorIcons.regular.basketball;

    case 'bathtub':
      return PhosphorIcons.regular.bathtub;

    case 'batteryCharging':
      return PhosphorIcons.regular.batteryCharging;

    case 'batteryChargingVertical':
      return PhosphorIcons.regular.batteryChargingVertical;

    case 'batteryEmpty':
      return PhosphorIcons.regular.batteryEmpty;

    case 'batteryFull':
      return PhosphorIcons.regular.batteryFull;

    case 'batteryHigh':
      return PhosphorIcons.regular.batteryHigh;

    case 'batteryLow':
      return PhosphorIcons.regular.batteryLow;

    case 'batteryMedium':
      return PhosphorIcons.regular.batteryMedium;

    case 'batteryPlus':
      return PhosphorIcons.regular.batteryPlus;

    case 'batteryPlusVertical':
      return PhosphorIcons.regular.batteryPlusVertical;

    case 'batteryVerticalEmpty':
      return PhosphorIcons.regular.batteryVerticalEmpty;

    case 'batteryVerticalFull':
      return PhosphorIcons.regular.batteryVerticalFull;

    case 'batteryVerticalHigh':
      return PhosphorIcons.regular.batteryVerticalHigh;

    case 'batteryVerticalLow':
      return PhosphorIcons.regular.batteryVerticalLow;

    case 'batteryVerticalMedium':
      return PhosphorIcons.regular.batteryVerticalMedium;

    case 'batteryWarning':
      return PhosphorIcons.regular.batteryWarning;

    case 'batteryWarningVertical':
      return PhosphorIcons.regular.batteryWarningVertical;

    case 'bed':
      return PhosphorIcons.regular.bed;

    case 'beerBottle':
      return PhosphorIcons.regular.beerBottle;

    case 'beerStein':
      return PhosphorIcons.regular.beerStein;

    case 'behanceLogo':
      return PhosphorIcons.regular.behanceLogo;

    case 'bell':
      return PhosphorIcons.regular.bell;

    case 'bellRinging':
      return PhosphorIcons.regular.bellRinging;

    case 'bellSimple':
      return PhosphorIcons.regular.bellSimple;

    case 'bellSimpleRinging':
      return PhosphorIcons.regular.bellSimpleRinging;

    case 'bellSimpleSlash':
      return PhosphorIcons.regular.bellSimpleSlash;

    case 'bellSimpleZ':
      return PhosphorIcons.regular.bellSimpleZ;

    case 'bellSlash':
      return PhosphorIcons.regular.bellSlash;

    case 'bellZ':
      return PhosphorIcons.regular.bellZ;

    case 'bezierCurve':
      return PhosphorIcons.regular.bezierCurve;

    case 'bicycle':
      return PhosphorIcons.regular.bicycle;

    case 'binoculars':
      return PhosphorIcons.regular.binoculars;

    case 'bird':
      return PhosphorIcons.regular.bird;

    case 'bluetooth':
      return PhosphorIcons.regular.bluetooth;

    case 'bluetoothConnected':
      return PhosphorIcons.regular.bluetoothConnected;

    case 'bluetoothSlash':
      return PhosphorIcons.regular.bluetoothSlash;

    case 'bluetoothX':
      return PhosphorIcons.regular.bluetoothX;

    case 'boat':
      return PhosphorIcons.regular.boat;

    case 'bone':
      return PhosphorIcons.regular.bone;

    case 'book':
      return PhosphorIcons.regular.book;

    case 'bookBookmark':
      return PhosphorIcons.regular.bookBookmark;

    case 'bookOpen':
      return PhosphorIcons.regular.bookOpen;

    case 'bookOpenText':
      return PhosphorIcons.regular.bookOpenText;

    case 'bookmark':
      return PhosphorIcons.regular.bookmark;

    case 'bookmarkSimple':
      return PhosphorIcons.regular.bookmarkSimple;

    case 'bookmarks':
      return PhosphorIcons.regular.bookmarks;

    case 'bookmarksSimple':
      return PhosphorIcons.regular.bookmarksSimple;

    case 'books':
      return PhosphorIcons.regular.books;

    case 'boot':
      return PhosphorIcons.regular.boot;

    case 'boundingBox':
      return PhosphorIcons.regular.boundingBox;

    case 'bowlFood':
      return PhosphorIcons.regular.bowlFood;

    case 'bracketsAngle':
      return PhosphorIcons.regular.bracketsAngle;

    case 'bracketsCurly':
      return PhosphorIcons.regular.bracketsCurly;

    case 'bracketsRound':
      return PhosphorIcons.regular.bracketsRound;

    case 'bracketsSquare':
      return PhosphorIcons.regular.bracketsSquare;

    case 'brain':
      return PhosphorIcons.regular.brain;

    case 'brandy':
      return PhosphorIcons.regular.brandy;

    case 'bridge':
      return PhosphorIcons.regular.bridge;

    case 'briefcase':
      return PhosphorIcons.regular.briefcase;

    case 'briefcaseMetal':
      return PhosphorIcons.regular.briefcaseMetal;

    case 'broadcast':
      return PhosphorIcons.regular.broadcast;

    case 'broom':
      return PhosphorIcons.regular.broom;

    case 'browser':
      return PhosphorIcons.regular.browser;

    case 'browsers':
      return PhosphorIcons.regular.browsers;

    case 'bug':
      return PhosphorIcons.regular.bug;

    case 'bugBeetle':
      return PhosphorIcons.regular.bugBeetle;

    case 'bugDroid':
      return PhosphorIcons.regular.bugDroid;

    case 'buildings':
      return PhosphorIcons.regular.buildings;

    case 'bus':
      return PhosphorIcons.regular.bus;

    case 'butterfly':
      return PhosphorIcons.regular.butterfly;

    case 'cactus':
      return PhosphorIcons.regular.cactus;

    case 'cake':
      return PhosphorIcons.regular.cake;

    case 'calculator':
      return PhosphorIcons.regular.calculator;

    case 'calendar':
      return PhosphorIcons.regular.calendar;

    case 'calendarBlank':
      return PhosphorIcons.regular.calendarBlank;

    case 'calendarCheck':
      return PhosphorIcons.regular.calendarCheck;

    case 'calendarPlus':
      return PhosphorIcons.regular.calendarPlus;

    case 'calendarX':
      return PhosphorIcons.regular.calendarX;

    case 'callBell':
      return PhosphorIcons.regular.callBell;

    case 'camera':
      return PhosphorIcons.regular.camera;

    case 'cameraPlus':
      return PhosphorIcons.regular.cameraPlus;

    case 'cameraRotate':
      return PhosphorIcons.regular.cameraRotate;

    case 'cameraSlash':
      return PhosphorIcons.regular.cameraSlash;

    case 'campfire':
      return PhosphorIcons.regular.campfire;

    case 'car':
      return PhosphorIcons.regular.car;

    case 'carProfile':
      return PhosphorIcons.regular.carProfile;

    case 'carSimple':
      return PhosphorIcons.regular.carSimple;

    case 'cardholder':
      return PhosphorIcons.regular.cardholder;

    case 'cards':
      return PhosphorIcons.regular.cards;

    case 'caretCircleDoubleDown':
      return PhosphorIcons.regular.caretCircleDoubleDown;

    case 'caretCircleDoubleLeft':
      return PhosphorIcons.regular.caretCircleDoubleLeft;

    case 'caretCircleDoubleRight':
      return PhosphorIcons.regular.caretCircleDoubleRight;

    case 'caretCircleDoubleUp':
      return PhosphorIcons.regular.caretCircleDoubleUp;

    case 'caretCircleDown':
      return PhosphorIcons.regular.caretCircleDown;

    case 'caretCircleLeft':
      return PhosphorIcons.regular.caretCircleLeft;

    case 'caretCircleRight':
      return PhosphorIcons.regular.caretCircleRight;

    case 'caretCircleUp':
      return PhosphorIcons.regular.caretCircleUp;

    case 'caretCircleUpDown':
      return PhosphorIcons.regular.caretCircleUpDown;

    case 'caretDoubleDown':
      return PhosphorIcons.regular.caretDoubleDown;

    case 'caretDoubleLeft':
      return PhosphorIcons.regular.caretDoubleLeft;

    case 'caretDoubleRight':
      return PhosphorIcons.regular.caretDoubleRight;

    case 'caretDoubleUp':
      return PhosphorIcons.regular.caretDoubleUp;

    case 'caretDown':
      return PhosphorIcons.regular.caretDown;

    case 'caretLeft':
      return PhosphorIcons.regular.caretLeft;

    case 'caretRight':
      return PhosphorIcons.regular.caretRight;

    case 'caretUp':
      return PhosphorIcons.regular.caretUp;

    case 'caretUpDown':
      return PhosphorIcons.regular.caretUpDown;

    case 'carrot':
      return PhosphorIcons.regular.carrot;

    case 'cassetteTape':
      return PhosphorIcons.regular.cassetteTape;

    case 'castleTurret':
      return PhosphorIcons.regular.castleTurret;

    case 'cat':
      return PhosphorIcons.regular.cat;

    case 'cellSignalFull':
      return PhosphorIcons.regular.cellSignalFull;

    case 'cellSignalHigh':
      return PhosphorIcons.regular.cellSignalHigh;

    case 'cellSignalLow':
      return PhosphorIcons.regular.cellSignalLow;

    case 'cellSignalMedium':
      return PhosphorIcons.regular.cellSignalMedium;

    case 'cellSignalNone':
      return PhosphorIcons.regular.cellSignalNone;

    case 'cellSignalSlash':
      return PhosphorIcons.regular.cellSignalSlash;

    case 'cellSignalX':
      return PhosphorIcons.regular.cellSignalX;

    case 'certificate':
      return PhosphorIcons.regular.certificate;

    case 'chair':
      return PhosphorIcons.regular.chair;

    case 'chalkboard':
      return PhosphorIcons.regular.chalkboard;

    case 'chalkboardSimple':
      return PhosphorIcons.regular.chalkboardSimple;

    case 'chalkboardTeacher':
      return PhosphorIcons.regular.chalkboardTeacher;

    case 'champagne':
      return PhosphorIcons.regular.champagne;

    case 'chargingStation':
      return PhosphorIcons.regular.chargingStation;

    case 'chartBar':
      return PhosphorIcons.regular.chartBar;

    case 'chartBarHorizontal':
      return PhosphorIcons.regular.chartBarHorizontal;

    case 'chartDonut':
      return PhosphorIcons.regular.chartDonut;

    case 'chartLine':
      return PhosphorIcons.regular.chartLine;

    case 'chartLineDown':
      return PhosphorIcons.regular.chartLineDown;

    case 'chartLineUp':
      return PhosphorIcons.regular.chartLineUp;

    case 'chartPie':
      return PhosphorIcons.regular.chartPie;

    case 'chartPieSlice':
      return PhosphorIcons.regular.chartPieSlice;

    case 'chartPolar':
      return PhosphorIcons.regular.chartPolar;

    case 'chartScatter':
      return PhosphorIcons.regular.chartScatter;

    case 'chat':
      return PhosphorIcons.regular.chat;

    case 'chatCentered':
      return PhosphorIcons.regular.chatCentered;

    case 'chatCenteredDots':
      return PhosphorIcons.regular.chatCenteredDots;

    case 'chatCenteredText':
      return PhosphorIcons.regular.chatCenteredText;

    case 'chatCircle':
      return PhosphorIcons.regular.chatCircle;

    case 'chatCircleDots':
      return PhosphorIcons.regular.chatCircleDots;

    case 'chatCircleText':
      return PhosphorIcons.regular.chatCircleText;

    case 'chatDots':
      return PhosphorIcons.regular.chatDots;

    case 'chatTeardrop':
      return PhosphorIcons.regular.chatTeardrop;

    case 'chatTeardropDots':
      return PhosphorIcons.regular.chatTeardropDots;

    case 'chatTeardropText':
      return PhosphorIcons.regular.chatTeardropText;

    case 'chatText':
      return PhosphorIcons.regular.chatText;

    case 'chats':
      return PhosphorIcons.regular.chats;

    case 'chatsCircle':
      return PhosphorIcons.regular.chatsCircle;

    case 'chatsTeardrop':
      return PhosphorIcons.regular.chatsTeardrop;

    case 'check':
      return PhosphorIcons.regular.check;

    case 'checkCircle':
      return PhosphorIcons.regular.checkCircle;

    case 'checkFat':
      return PhosphorIcons.regular.checkFat;

    case 'checkSquare':
      return PhosphorIcons.regular.checkSquare;

    case 'checkSquareOffset':
      return PhosphorIcons.regular.checkSquareOffset;

    case 'checks':
      return PhosphorIcons.regular.checks;

    case 'church':
      return PhosphorIcons.regular.church;

    case 'circle':
      return PhosphorIcons.regular.circle;

    case 'circleDashed':
      return PhosphorIcons.regular.circleDashed;

    case 'circleHalf':
      return PhosphorIcons.regular.circleHalf;

    case 'circleHalfTilt':
      return PhosphorIcons.regular.circleHalfTilt;

    case 'circleNotch':
      return PhosphorIcons.regular.circleNotch;

    case 'circlesFour':
      return PhosphorIcons.regular.circlesFour;

    case 'circlesThree':
      return PhosphorIcons.regular.circlesThree;

    case 'circlesThreePlus':
      return PhosphorIcons.regular.circlesThreePlus;

    case 'circuitry':
      return PhosphorIcons.regular.circuitry;

    case 'clipboard':
      return PhosphorIcons.regular.clipboard;

    case 'clipboardText':
      return PhosphorIcons.regular.clipboardText;

    case 'clock':
      return PhosphorIcons.regular.clock;

    case 'clockAfternoon':
      return PhosphorIcons.regular.clockAfternoon;

    case 'clockClockwise':
      return PhosphorIcons.regular.clockClockwise;

    case 'clockCountdown':
      return PhosphorIcons.regular.clockCountdown;

    case 'clockCounterClockwise':
      return PhosphorIcons.regular.clockCounterClockwise;

    case 'closedCaptioning':
      return PhosphorIcons.regular.closedCaptioning;

    case 'cloud':
      return PhosphorIcons.regular.cloud;

    case 'cloudArrowDown':
      return PhosphorIcons.regular.cloudArrowDown;

    case 'cloudArrowUp':
      return PhosphorIcons.regular.cloudArrowUp;

    case 'cloudCheck':
      return PhosphorIcons.regular.cloudCheck;

    case 'cloudFog':
      return PhosphorIcons.regular.cloudFog;

    case 'cloudLightning':
      return PhosphorIcons.regular.cloudLightning;

    case 'cloudMoon':
      return PhosphorIcons.regular.cloudMoon;

    case 'cloudRain':
      return PhosphorIcons.regular.cloudRain;

    case 'cloudSlash':
      return PhosphorIcons.regular.cloudSlash;

    case 'cloudSnow':
      return PhosphorIcons.regular.cloudSnow;

    case 'cloudSun':
      return PhosphorIcons.regular.cloudSun;

    case 'cloudWarning':
      return PhosphorIcons.regular.cloudWarning;

    case 'cloudX':
      return PhosphorIcons.regular.cloudX;

    case 'club':
      return PhosphorIcons.regular.club;

    case 'coatHanger':
      return PhosphorIcons.regular.coatHanger;

    case 'codaLogo':
      return PhosphorIcons.regular.codaLogo;

    case 'code':
      return PhosphorIcons.regular.code;

    case 'codeBlock':
      return PhosphorIcons.regular.codeBlock;

    case 'codeSimple':
      return PhosphorIcons.regular.codeSimple;

    case 'codepenLogo':
      return PhosphorIcons.regular.codepenLogo;

    case 'codesandboxLogo':
      return PhosphorIcons.regular.codesandboxLogo;

    case 'coffee':
      return PhosphorIcons.regular.coffee;

    case 'coin':
      return PhosphorIcons.regular.coin;

    case 'coinVertical':
      return PhosphorIcons.regular.coinVertical;

    case 'coins':
      return PhosphorIcons.regular.coins;

    case 'columns':
      return PhosphorIcons.regular.columns;

    case 'command':
      return PhosphorIcons.regular.command;

    case 'compass':
      return PhosphorIcons.regular.compass;

    case 'compassTool':
      return PhosphorIcons.regular.compassTool;

    case 'computerTower':
      return PhosphorIcons.regular.computerTower;

    case 'confetti':
      return PhosphorIcons.regular.confetti;

    case 'contactlessPayment':
      return PhosphorIcons.regular.contactlessPayment;

    case 'control':
      return PhosphorIcons.regular.control;

    case 'cookie':
      return PhosphorIcons.regular.cookie;

    case 'cookingPot':
      return PhosphorIcons.regular.cookingPot;

    case 'copy':
      return PhosphorIcons.regular.copy;

    case 'copySimple':
      return PhosphorIcons.regular.copySimple;

    case 'copyleft':
      return PhosphorIcons.regular.copyleft;

    case 'copyright':
      return PhosphorIcons.regular.copyright;

    case 'cornersIn':
      return PhosphorIcons.regular.cornersIn;

    case 'cornersOut':
      return PhosphorIcons.regular.cornersOut;

    case 'couch':
      return PhosphorIcons.regular.couch;

    case 'cpu':
      return PhosphorIcons.regular.cpu;

    case 'creditCard':
      return PhosphorIcons.regular.creditCard;

    case 'crop':
      return PhosphorIcons.regular.crop;

    case 'cross':
      return PhosphorIcons.regular.cross;

    case 'crosshair':
      return PhosphorIcons.regular.crosshair;

    case 'crosshairSimple':
      return PhosphorIcons.regular.crosshairSimple;

    case 'crown':
      return PhosphorIcons.regular.crown;

    case 'crownSimple':
      return PhosphorIcons.regular.crownSimple;

    case 'cube':
      return PhosphorIcons.regular.cube;

    case 'cubeFocus':
      return PhosphorIcons.regular.cubeFocus;

    case 'cubeTransparent':
      return PhosphorIcons.regular.cubeTransparent;

    case 'currencyBtc':
      return PhosphorIcons.regular.currencyBtc;

    case 'currencyCircleDollar':
      return PhosphorIcons.regular.currencyCircleDollar;

    case 'currencyCny':
      return PhosphorIcons.regular.currencyCny;

    case 'currencyDollar':
      return PhosphorIcons.regular.currencyDollar;

    case 'currencyDollarSimple':
      return PhosphorIcons.regular.currencyDollarSimple;

    case 'currencyEth':
      return PhosphorIcons.regular.currencyEth;

    case 'currencyEur':
      return PhosphorIcons.regular.currencyEur;

    case 'currencyGbp':
      return PhosphorIcons.regular.currencyGbp;

    case 'currencyInr':
      return PhosphorIcons.regular.currencyInr;

    case 'currencyJpy':
      return PhosphorIcons.regular.currencyJpy;

    case 'currencyKrw':
      return PhosphorIcons.regular.currencyKrw;

    case 'currencyKzt':
      return PhosphorIcons.regular.currencyKzt;

    case 'currencyNgn':
      return PhosphorIcons.regular.currencyNgn;

    case 'currencyRub':
      return PhosphorIcons.regular.currencyRub;

    case 'cursor':
      return PhosphorIcons.regular.cursor;

    case 'cursorClick':
      return PhosphorIcons.regular.cursorClick;

    case 'cursorText':
      return PhosphorIcons.regular.cursorText;

    case 'cylinder':
      return PhosphorIcons.regular.cylinder;

    case 'database':
      return PhosphorIcons.regular.database;

    case 'desktop':
      return PhosphorIcons.regular.desktop;

    case 'desktopTower':
      return PhosphorIcons.regular.desktopTower;

    case 'detective':
      return PhosphorIcons.regular.detective;

    case 'devToLogo':
      return PhosphorIcons.regular.devToLogo;

    case 'deviceMobile':
      return PhosphorIcons.regular.deviceMobile;

    case 'deviceMobileCamera':
      return PhosphorIcons.regular.deviceMobileCamera;

    case 'deviceMobileSpeaker':
      return PhosphorIcons.regular.deviceMobileSpeaker;

    case 'deviceTablet':
      return PhosphorIcons.regular.deviceTablet;

    case 'deviceTabletCamera':
      return PhosphorIcons.regular.deviceTabletCamera;

    case 'deviceTabletSpeaker':
      return PhosphorIcons.regular.deviceTabletSpeaker;

    case 'devices':
      return PhosphorIcons.regular.devices;

    case 'diamond':
      return PhosphorIcons.regular.diamond;

    case 'diamondsFour':
      return PhosphorIcons.regular.diamondsFour;

    case 'diceFive':
      return PhosphorIcons.regular.diceFive;

    case 'diceFour':
      return PhosphorIcons.regular.diceFour;

    case 'diceOne':
      return PhosphorIcons.regular.diceOne;

    case 'diceSix':
      return PhosphorIcons.regular.diceSix;

    case 'diceThree':
      return PhosphorIcons.regular.diceThree;

    case 'diceTwo':
      return PhosphorIcons.regular.diceTwo;

    case 'disc':
      return PhosphorIcons.regular.disc;

    case 'discordLogo':
      return PhosphorIcons.regular.discordLogo;

    case 'divide':
      return PhosphorIcons.regular.divide;

    case 'dna':
      return PhosphorIcons.regular.dna;

    case 'dog':
      return PhosphorIcons.regular.dog;

    case 'door':
      return PhosphorIcons.regular.door;

    case 'doorOpen':
      return PhosphorIcons.regular.doorOpen;

    case 'dot':
      return PhosphorIcons.regular.dot;

    case 'dotOutline':
      return PhosphorIcons.regular.dotOutline;

    case 'dotsNine':
      return PhosphorIcons.regular.dotsNine;

    case 'dotsSix':
      return PhosphorIcons.regular.dotsSix;

    case 'dotsSixVertical':
      return PhosphorIcons.regular.dotsSixVertical;

    case 'dotsThree':
      return PhosphorIcons.regular.dotsThree;

    case 'dotsThreeCircle':
      return PhosphorIcons.regular.dotsThreeCircle;

    case 'dotsThreeCircleVertical':
      return PhosphorIcons.regular.dotsThreeCircleVertical;

    case 'dotsThreeOutline':
      return PhosphorIcons.regular.dotsThreeOutline;

    case 'dotsThreeOutlineVertical':
      return PhosphorIcons.regular.dotsThreeOutlineVertical;

    case 'dotsThreeVertical':
      return PhosphorIcons.regular.dotsThreeVertical;

    case 'download':
      return PhosphorIcons.regular.download;

    case 'downloadSimple':
      return PhosphorIcons.regular.downloadSimple;

    case 'dress':
      return PhosphorIcons.regular.dress;

    case 'dribbbleLogo':
      return PhosphorIcons.regular.dribbbleLogo;

    case 'drop':
      return PhosphorIcons.regular.drop;

    case 'dropHalf':
      return PhosphorIcons.regular.dropHalf;

    case 'dropHalfBottom':
      return PhosphorIcons.regular.dropHalfBottom;

    case 'dropboxLogo':
      return PhosphorIcons.regular.dropboxLogo;

    case 'ear':
      return PhosphorIcons.regular.ear;

    case 'earSlash':
      return PhosphorIcons.regular.earSlash;

    case 'egg':
      return PhosphorIcons.regular.egg;

    case 'eggCrack':
      return PhosphorIcons.regular.eggCrack;

    case 'eject':
      return PhosphorIcons.regular.eject;

    case 'ejectSimple':
      return PhosphorIcons.regular.ejectSimple;

    case 'elevator':
      return PhosphorIcons.regular.elevator;

    case 'engine':
      return PhosphorIcons.regular.engine;

    case 'envelope':
      return PhosphorIcons.regular.envelope;

    case 'envelopeOpen':
      return PhosphorIcons.regular.envelopeOpen;

    case 'envelopeSimple':
      return PhosphorIcons.regular.envelopeSimple;

    case 'envelopeSimpleOpen':
      return PhosphorIcons.regular.envelopeSimpleOpen;

    case 'equalizer':
      return PhosphorIcons.regular.equalizer;

    case 'equals':
      return PhosphorIcons.regular.equals;

    case 'eraser':
      return PhosphorIcons.regular.eraser;

    case 'escalatorDown':
      return PhosphorIcons.regular.escalatorDown;

    case 'escalatorUp':
      return PhosphorIcons.regular.escalatorUp;

    case 'exam':
      return PhosphorIcons.regular.exam;

    case 'exclude':
      return PhosphorIcons.regular.exclude;

    case 'excludeSquare':
      return PhosphorIcons.regular.excludeSquare;

    case 'export':
      return PhosphorIcons.regular.export;

    case 'eye':
      return PhosphorIcons.regular.eye;

    case 'eyeClosed':
      return PhosphorIcons.regular.eyeClosed;

    case 'eyeSlash':
      return PhosphorIcons.regular.eyeSlash;

    case 'eyedropper':
      return PhosphorIcons.regular.eyedropper;

    case 'eyedropperSample':
      return PhosphorIcons.regular.eyedropperSample;

    case 'eyeglasses':
      return PhosphorIcons.regular.eyeglasses;

    case 'faceMask':
      return PhosphorIcons.regular.faceMask;

    case 'facebookLogo':
      return PhosphorIcons.regular.facebookLogo;

    case 'factory':
      return PhosphorIcons.regular.factory;

    case 'faders':
      return PhosphorIcons.regular.faders;

    case 'fadersHorizontal':
      return PhosphorIcons.regular.fadersHorizontal;

    case 'fan':
      return PhosphorIcons.regular.fan;

    case 'fastForward':
      return PhosphorIcons.regular.fastForward;

    case 'fastForwardCircle':
      return PhosphorIcons.regular.fastForwardCircle;

    case 'feather':
      return PhosphorIcons.regular.feather;

    case 'figmaLogo':
      return PhosphorIcons.regular.figmaLogo;

    case 'file':
      return PhosphorIcons.regular.file;

    case 'fileArchive':
      return PhosphorIcons.regular.fileArchive;

    case 'fileArrowDown':
      return PhosphorIcons.regular.fileArrowDown;

    case 'fileArrowUp':
      return PhosphorIcons.regular.fileArrowUp;

    case 'fileAudio':
      return PhosphorIcons.regular.fileAudio;

    case 'fileCloud':
      return PhosphorIcons.regular.fileCloud;

    case 'fileCode':
      return PhosphorIcons.regular.fileCode;

    case 'fileCss':
      return PhosphorIcons.regular.fileCss;

    case 'fileCsv':
      return PhosphorIcons.regular.fileCsv;

    case 'fileDashed':
      return PhosphorIcons.regular.fileDashed;

    case 'fileDoc':
      return PhosphorIcons.regular.fileDoc;

    case 'fileHtml':
      return PhosphorIcons.regular.fileHtml;

    case 'fileImage':
      return PhosphorIcons.regular.fileImage;

    case 'fileJpg':
      return PhosphorIcons.regular.fileJpg;

    case 'fileJs':
      return PhosphorIcons.regular.fileJs;

    case 'fileJsx':
      return PhosphorIcons.regular.fileJsx;

    case 'fileLock':
      return PhosphorIcons.regular.fileLock;

    case 'fileMagnifyingGlass':
      return PhosphorIcons.regular.fileMagnifyingGlass;

    case 'fileMinus':
      return PhosphorIcons.regular.fileMinus;

    case 'filePdf':
      return PhosphorIcons.regular.filePdf;

    case 'filePlus':
      return PhosphorIcons.regular.filePlus;

    case 'filePng':
      return PhosphorIcons.regular.filePng;

    case 'filePpt':
      return PhosphorIcons.regular.filePpt;

    case 'fileRs':
      return PhosphorIcons.regular.fileRs;

    case 'fileSql':
      return PhosphorIcons.regular.fileSql;

    case 'fileText':
      return PhosphorIcons.regular.fileText;

    case 'fileTs':
      return PhosphorIcons.regular.fileTs;

    case 'fileTsx':
      return PhosphorIcons.regular.fileTsx;

    case 'fileVideo':
      return PhosphorIcons.regular.fileVideo;

    case 'fileVue':
      return PhosphorIcons.regular.fileVue;

    case 'fileX':
      return PhosphorIcons.regular.fileX;

    case 'fileXls':
      return PhosphorIcons.regular.fileXls;

    case 'fileZip':
      return PhosphorIcons.regular.fileZip;

    case 'files':
      return PhosphorIcons.regular.files;

    case 'filmReel':
      return PhosphorIcons.regular.filmReel;

    case 'filmScript':
      return PhosphorIcons.regular.filmScript;

    case 'filmSlate':
      return PhosphorIcons.regular.filmSlate;

    case 'filmStrip':
      return PhosphorIcons.regular.filmStrip;

    case 'fingerprint':
      return PhosphorIcons.regular.fingerprint;

    case 'fingerprintSimple':
      return PhosphorIcons.regular.fingerprintSimple;

    case 'finnTheHuman':
      return PhosphorIcons.regular.finnTheHuman;

    case 'fire':
      return PhosphorIcons.regular.fire;

    case 'fireExtinguisher':
      return PhosphorIcons.regular.fireExtinguisher;

    case 'fireSimple':
      return PhosphorIcons.regular.fireSimple;

    case 'firstAid':
      return PhosphorIcons.regular.firstAid;

    case 'firstAidKit':
      return PhosphorIcons.regular.firstAidKit;

    case 'fish':
      return PhosphorIcons.regular.fish;

    case 'fishSimple':
      return PhosphorIcons.regular.fishSimple;

    case 'flag':
      return PhosphorIcons.regular.flag;

    case 'flagBanner':
      return PhosphorIcons.regular.flagBanner;

    case 'flagCheckered':
      return PhosphorIcons.regular.flagCheckered;

    case 'flagPennant':
      return PhosphorIcons.regular.flagPennant;

    case 'flame':
      return PhosphorIcons.regular.flame;

    case 'flashlight':
      return PhosphorIcons.regular.flashlight;

    case 'flask':
      return PhosphorIcons.regular.flask;

    case 'floppyDisk':
      return PhosphorIcons.regular.floppyDisk;

    case 'floppyDiskBack':
      return PhosphorIcons.regular.floppyDiskBack;

    case 'flowArrow':
      return PhosphorIcons.regular.flowArrow;

    case 'flower':
      return PhosphorIcons.regular.flower;

    case 'flowerLotus':
      return PhosphorIcons.regular.flowerLotus;

    case 'flowerTulip':
      return PhosphorIcons.regular.flowerTulip;

    case 'flyingSaucer':
      return PhosphorIcons.regular.flyingSaucer;

    case 'folder':
      return PhosphorIcons.regular.folder;

    case 'folderDashed':
      return PhosphorIcons.regular.folderDashed;

    case 'folderLock':
      return PhosphorIcons.regular.folderLock;

    case 'folderMinus':
      return PhosphorIcons.regular.folderMinus;

    case 'folderNotch':
      return PhosphorIcons.regular.folderNotch;

    case 'folderNotchMinus':
      return PhosphorIcons.regular.folderNotchMinus;

    case 'folderNotchOpen':
      return PhosphorIcons.regular.folderNotchOpen;

    case 'folderNotchPlus':
      return PhosphorIcons.regular.folderNotchPlus;

    case 'folderOpen':
      return PhosphorIcons.regular.folderOpen;

    case 'folderPlus':
      return PhosphorIcons.regular.folderPlus;

    case 'folderSimple':
      return PhosphorIcons.regular.folderSimple;

    case 'folderSimpleDashed':
      return PhosphorIcons.regular.folderSimpleDashed;

    case 'folderSimpleLock':
      return PhosphorIcons.regular.folderSimpleLock;

    case 'folderSimpleMinus':
      return PhosphorIcons.regular.folderSimpleMinus;

    case 'folderSimplePlus':
      return PhosphorIcons.regular.folderSimplePlus;

    case 'folderSimpleStar':
      return PhosphorIcons.regular.folderSimpleStar;

    case 'folderSimpleUser':
      return PhosphorIcons.regular.folderSimpleUser;

    case 'folderStar':
      return PhosphorIcons.regular.folderStar;

    case 'folderUser':
      return PhosphorIcons.regular.folderUser;

    case 'folders':
      return PhosphorIcons.regular.folders;

    case 'football':
      return PhosphorIcons.regular.football;

    case 'footprints':
      return PhosphorIcons.regular.footprints;

    case 'forkKnife':
      return PhosphorIcons.regular.forkKnife;

    case 'frameCorners':
      return PhosphorIcons.regular.frameCorners;

    case 'framerLogo':
      return PhosphorIcons.regular.framerLogo;

    case 'function':
      return PhosphorIcons.regular.function;

    case 'funnel':
      return PhosphorIcons.regular.funnel;

    case 'funnelSimple':
      return PhosphorIcons.regular.funnelSimple;

    case 'gameController':
      return PhosphorIcons.regular.gameController;

    case 'garage':
      return PhosphorIcons.regular.garage;

    case 'gasCan':
      return PhosphorIcons.regular.gasCan;

    case 'gasPump':
      return PhosphorIcons.regular.gasPump;

    case 'gauge':
      return PhosphorIcons.regular.gauge;

    case 'gavel':
      return PhosphorIcons.regular.gavel;

    case 'gear':
      return PhosphorIcons.regular.gear;

    case 'gearFine':
      return PhosphorIcons.regular.gearFine;

    case 'gearSix':
      return PhosphorIcons.regular.gearSix;

    case 'genderFemale':
      return PhosphorIcons.regular.genderFemale;

    case 'genderIntersex':
      return PhosphorIcons.regular.genderIntersex;

    case 'genderMale':
      return PhosphorIcons.regular.genderMale;

    case 'genderNeuter':
      return PhosphorIcons.regular.genderNeuter;

    case 'genderNonbinary':
      return PhosphorIcons.regular.genderNonbinary;

    case 'genderTransgender':
      return PhosphorIcons.regular.genderTransgender;

    case 'ghost':
      return PhosphorIcons.regular.ghost;

    case 'gif':
      return PhosphorIcons.regular.gif;

    case 'gift':
      return PhosphorIcons.regular.gift;

    case 'gitBranch':
      return PhosphorIcons.regular.gitBranch;

    case 'gitCommit':
      return PhosphorIcons.regular.gitCommit;

    case 'gitDiff':
      return PhosphorIcons.regular.gitDiff;

    case 'gitFork':
      return PhosphorIcons.regular.gitFork;

    case 'gitMerge':
      return PhosphorIcons.regular.gitMerge;

    case 'gitPullRequest':
      return PhosphorIcons.regular.gitPullRequest;

    case 'githubLogo':
      return PhosphorIcons.regular.githubLogo;

    case 'gitlabLogo':
      return PhosphorIcons.regular.gitlabLogo;

    case 'gitlabLogoSimple':
      return PhosphorIcons.regular.gitlabLogoSimple;

    case 'globe':
      return PhosphorIcons.regular.globe;

    case 'globeHemisphereEast':
      return PhosphorIcons.regular.globeHemisphereEast;

    case 'globeHemisphereWest':
      return PhosphorIcons.regular.globeHemisphereWest;

    case 'globeSimple':
      return PhosphorIcons.regular.globeSimple;

    case 'globeStand':
      return PhosphorIcons.regular.globeStand;

    case 'goggles':
      return PhosphorIcons.regular.goggles;

    case 'goodreadsLogo':
      return PhosphorIcons.regular.goodreadsLogo;

    case 'googleCardboardLogo':
      return PhosphorIcons.regular.googleCardboardLogo;

    case 'googleChromeLogo':
      return PhosphorIcons.regular.googleChromeLogo;

    case 'googleDriveLogo':
      return PhosphorIcons.regular.googleDriveLogo;

    case 'googleLogo':
      return PhosphorIcons.regular.googleLogo;

    case 'googlePhotosLogo':
      return PhosphorIcons.regular.googlePhotosLogo;

    case 'googlePlayLogo':
      return PhosphorIcons.regular.googlePlayLogo;

    case 'googlePodcastsLogo':
      return PhosphorIcons.regular.googlePodcastsLogo;

    case 'gradient':
      return PhosphorIcons.regular.gradient;

    case 'graduationCap':
      return PhosphorIcons.regular.graduationCap;

    case 'grains':
      return PhosphorIcons.regular.grains;

    case 'grainsSlash':
      return PhosphorIcons.regular.grainsSlash;

    case 'graph':
      return PhosphorIcons.regular.graph;

    case 'gridFour':
      return PhosphorIcons.regular.gridFour;

    case 'gridNine':
      return PhosphorIcons.regular.gridNine;

    case 'guitar':
      return PhosphorIcons.regular.guitar;

    case 'hamburger':
      return PhosphorIcons.regular.hamburger;

    case 'hammer':
      return PhosphorIcons.regular.hammer;

    case 'hand':
      return PhosphorIcons.regular.hand;

    case 'handCoins':
      return PhosphorIcons.regular.handCoins;

    case 'handEye':
      return PhosphorIcons.regular.handEye;

    case 'handFist':
      return PhosphorIcons.regular.handFist;

    case 'handGrabbing':
      return PhosphorIcons.regular.handGrabbing;

    case 'handHeart':
      return PhosphorIcons.regular.handHeart;

    case 'handPalm':
      return PhosphorIcons.regular.handPalm;

    case 'handPointing':
      return PhosphorIcons.regular.handPointing;

    case 'handSoap':
      return PhosphorIcons.regular.handSoap;

    case 'handSwipeLeft':
      return PhosphorIcons.regular.handSwipeLeft;

    case 'handSwipeRight':
      return PhosphorIcons.regular.handSwipeRight;

    case 'handTap':
      return PhosphorIcons.regular.handTap;

    case 'handWaving':
      return PhosphorIcons.regular.handWaving;

    case 'handbag':
      return PhosphorIcons.regular.handbag;

    case 'handbagSimple':
      return PhosphorIcons.regular.handbagSimple;

    case 'handsClapping':
      return PhosphorIcons.regular.handsClapping;

    case 'handsPraying':
      return PhosphorIcons.regular.handsPraying;

    case 'handshake':
      return PhosphorIcons.regular.handshake;

    case 'hardDrive':
      return PhosphorIcons.regular.hardDrive;

    case 'hardDrives':
      return PhosphorIcons.regular.hardDrives;

    case 'hash':
      return PhosphorIcons.regular.hash;

    case 'hashStraight':
      return PhosphorIcons.regular.hashStraight;

    case 'headlights':
      return PhosphorIcons.regular.headlights;

    case 'headphones':
      return PhosphorIcons.regular.headphones;

    case 'headset':
      return PhosphorIcons.regular.headset;

    case 'heart':
      return PhosphorIcons.regular.heart;

    case 'heartBreak':
      return PhosphorIcons.regular.heartBreak;

    case 'heartHalf':
      return PhosphorIcons.regular.heartHalf;

    case 'heartStraight':
      return PhosphorIcons.regular.heartStraight;

    case 'heartStraightBreak':
      return PhosphorIcons.regular.heartStraightBreak;

    case 'heartbeat':
      return PhosphorIcons.regular.heartbeat;

    case 'hexagon':
      return PhosphorIcons.regular.hexagon;

    case 'highHeel':
      return PhosphorIcons.regular.highHeel;

    case 'highlighterCircle':
      return PhosphorIcons.regular.highlighterCircle;

    case 'hoodie':
      return PhosphorIcons.regular.hoodie;

    case 'horse':
      return PhosphorIcons.regular.horse;

    case 'hourglass':
      return PhosphorIcons.regular.hourglass;

    case 'hourglassHigh':
      return PhosphorIcons.regular.hourglassHigh;

    case 'hourglassLow':
      return PhosphorIcons.regular.hourglassLow;

    case 'hourglassMedium':
      return PhosphorIcons.regular.hourglassMedium;

    case 'hourglassSimple':
      return PhosphorIcons.regular.hourglassSimple;

    case 'hourglassSimpleHigh':
      return PhosphorIcons.regular.hourglassSimpleHigh;

    case 'hourglassSimpleLow':
      return PhosphorIcons.regular.hourglassSimpleLow;

    case 'hourglassSimpleMedium':
      return PhosphorIcons.regular.hourglassSimpleMedium;

    case 'house':
      return PhosphorIcons.regular.house;

    case 'houseLine':
      return PhosphorIcons.regular.houseLine;

    case 'houseSimple':
      return PhosphorIcons.regular.houseSimple;

    case 'iceCream':
      return PhosphorIcons.regular.iceCream;

    case 'identificationBadge':
      return PhosphorIcons.regular.identificationBadge;

    case 'identificationCard':
      return PhosphorIcons.regular.identificationCard;

    case 'image':
      return PhosphorIcons.regular.image;

    case 'imageSquare':
      return PhosphorIcons.regular.imageSquare;

    case 'images':
      return PhosphorIcons.regular.images;

    case 'imagesSquare':
      return PhosphorIcons.regular.imagesSquare;

    case 'infinity':
      return PhosphorIcons.regular.infinity;

    case 'info':
      return PhosphorIcons.regular.info;

    case 'instagramLogo':
      return PhosphorIcons.regular.instagramLogo;

    case 'intersect':
      return PhosphorIcons.regular.intersect;

    case 'intersectSquare':
      return PhosphorIcons.regular.intersectSquare;

    case 'intersectThree':
      return PhosphorIcons.regular.intersectThree;

    case 'jeep':
      return PhosphorIcons.regular.jeep;

    case 'kanban':
      return PhosphorIcons.regular.kanban;

    case 'key':
      return PhosphorIcons.regular.key;

    case 'keyReturn':
      return PhosphorIcons.regular.keyReturn;

    case 'keyboard':
      return PhosphorIcons.regular.keyboard;

    case 'keyhole':
      return PhosphorIcons.regular.keyhole;

    case 'knife':
      return PhosphorIcons.regular.knife;

    case 'ladder':
      return PhosphorIcons.regular.ladder;

    case 'ladderSimple':
      return PhosphorIcons.regular.ladderSimple;

    case 'lamp':
      return PhosphorIcons.regular.lamp;

    case 'laptop':
      return PhosphorIcons.regular.laptop;

    case 'layout':
      return PhosphorIcons.regular.layout;

    case 'leaf':
      return PhosphorIcons.regular.leaf;

    case 'lifebuoy':
      return PhosphorIcons.regular.lifebuoy;

    case 'lightbulb':
      return PhosphorIcons.regular.lightbulb;

    case 'lightbulbFilament':
      return PhosphorIcons.regular.lightbulbFilament;

    case 'lighthouse':
      return PhosphorIcons.regular.lighthouse;

    case 'lightning':
      return PhosphorIcons.regular.lightning;

    case 'lightningA':
      return PhosphorIcons.regular.lightningA;

    case 'lightningSlash':
      return PhosphorIcons.regular.lightningSlash;

    case 'lineSegment':
      return PhosphorIcons.regular.lineSegment;

    case 'lineSegments':
      return PhosphorIcons.regular.lineSegments;

    case 'link':
      return PhosphorIcons.regular.link;

    case 'linkBreak':
      return PhosphorIcons.regular.linkBreak;

    case 'linkSimple':
      return PhosphorIcons.regular.linkSimple;

    case 'linkSimpleBreak':
      return PhosphorIcons.regular.linkSimpleBreak;

    case 'linkSimpleHorizontal':
      return PhosphorIcons.regular.linkSimpleHorizontal;

    case 'linkSimpleHorizontalBreak':
      return PhosphorIcons.regular.linkSimpleHorizontalBreak;

    case 'linkedinLogo':
      return PhosphorIcons.regular.linkedinLogo;

    case 'linuxLogo':
      return PhosphorIcons.regular.linuxLogo;

    case 'list':
      return PhosphorIcons.regular.list;

    case 'listBullets':
      return PhosphorIcons.regular.listBullets;

    case 'listChecks':
      return PhosphorIcons.regular.listChecks;

    case 'listDashes':
      return PhosphorIcons.regular.listDashes;

    case 'listMagnifyingGlass':
      return PhosphorIcons.regular.listMagnifyingGlass;

    case 'listNumbers':
      return PhosphorIcons.regular.listNumbers;

    case 'listPlus':
      return PhosphorIcons.regular.listPlus;

    case 'lock':
      return PhosphorIcons.regular.lock;

    case 'lockKey':
      return PhosphorIcons.regular.lockKey;

    case 'lockKeyOpen':
      return PhosphorIcons.regular.lockKeyOpen;

    case 'lockLaminated':
      return PhosphorIcons.regular.lockLaminated;

    case 'lockLaminatedOpen':
      return PhosphorIcons.regular.lockLaminatedOpen;

    case 'lockOpen':
      return PhosphorIcons.regular.lockOpen;

    case 'lockSimple':
      return PhosphorIcons.regular.lockSimple;

    case 'lockSimpleOpen':
      return PhosphorIcons.regular.lockSimpleOpen;

    case 'lockers':
      return PhosphorIcons.regular.lockers;

    case 'magicWand':
      return PhosphorIcons.regular.magicWand;

    case 'magnet':
      return PhosphorIcons.regular.magnet;

    case 'magnetStraight':
      return PhosphorIcons.regular.magnetStraight;

    case 'magnifyingGlass':
      return PhosphorIcons.regular.magnifyingGlass;

    case 'magnifyingGlassMinus':
      return PhosphorIcons.regular.magnifyingGlassMinus;

    case 'magnifyingGlassPlus':
      return PhosphorIcons.regular.magnifyingGlassPlus;

    case 'mapPin':
      return PhosphorIcons.regular.mapPin;

    case 'mapPinLine':
      return PhosphorIcons.regular.mapPinLine;

    case 'mapTrifold':
      return PhosphorIcons.regular.mapTrifold;

    case 'markerCircle':
      return PhosphorIcons.regular.markerCircle;

    case 'martini':
      return PhosphorIcons.regular.martini;

    case 'maskHappy':
      return PhosphorIcons.regular.maskHappy;

    case 'maskSad':
      return PhosphorIcons.regular.maskSad;

    case 'mathOperations':
      return PhosphorIcons.regular.mathOperations;

    case 'medal':
      return PhosphorIcons.regular.medal;

    case 'medalMilitary':
      return PhosphorIcons.regular.medalMilitary;

    case 'mediumLogo':
      return PhosphorIcons.regular.mediumLogo;

    case 'megaphone':
      return PhosphorIcons.regular.megaphone;

    case 'megaphoneSimple':
      return PhosphorIcons.regular.megaphoneSimple;

    case 'messengerLogo':
      return PhosphorIcons.regular.messengerLogo;

    case 'metaLogo':
      return PhosphorIcons.regular.metaLogo;

    case 'metronome':
      return PhosphorIcons.regular.metronome;

    case 'microphone':
      return PhosphorIcons.regular.microphone;

    case 'microphoneSlash':
      return PhosphorIcons.regular.microphoneSlash;

    case 'microphoneStage':
      return PhosphorIcons.regular.microphoneStage;

    case 'microsoftExcelLogo':
      return PhosphorIcons.regular.microsoftExcelLogo;

    case 'microsoftOutlookLogo':
      return PhosphorIcons.regular.microsoftOutlookLogo;

    case 'microsoftPowerpointLogo':
      return PhosphorIcons.regular.microsoftPowerpointLogo;

    case 'microsoftTeamsLogo':
      return PhosphorIcons.regular.microsoftTeamsLogo;

    case 'microsoftWordLogo':
      return PhosphorIcons.regular.microsoftWordLogo;

    case 'minus':
      return PhosphorIcons.regular.minus;

    case 'minusCircle':
      return PhosphorIcons.regular.minusCircle;

    case 'minusSquare':
      return PhosphorIcons.regular.minusSquare;

    case 'money':
      return PhosphorIcons.regular.money;

    case 'monitor':
      return PhosphorIcons.regular.monitor;

    case 'monitorPlay':
      return PhosphorIcons.regular.monitorPlay;

    case 'moon':
      return PhosphorIcons.regular.moon;

    case 'moonStars':
      return PhosphorIcons.regular.moonStars;

    case 'moped':
      return PhosphorIcons.regular.moped;

    case 'mopedFront':
      return PhosphorIcons.regular.mopedFront;

    case 'mosque':
      return PhosphorIcons.regular.mosque;

    case 'motorcycle':
      return PhosphorIcons.regular.motorcycle;

    case 'mountains':
      return PhosphorIcons.regular.mountains;

    case 'mouse':
      return PhosphorIcons.regular.mouse;

    case 'mouseSimple':
      return PhosphorIcons.regular.mouseSimple;

    case 'musicNote':
      return PhosphorIcons.regular.musicNote;

    case 'musicNoteSimple':
      return PhosphorIcons.regular.musicNoteSimple;

    case 'musicNotes':
      return PhosphorIcons.regular.musicNotes;

    case 'musicNotesPlus':
      return PhosphorIcons.regular.musicNotesPlus;

    case 'musicNotesSimple':
      return PhosphorIcons.regular.musicNotesSimple;

    case 'navigationArrow':
      return PhosphorIcons.regular.navigationArrow;

    case 'needle':
      return PhosphorIcons.regular.needle;

    case 'newspaper':
      return PhosphorIcons.regular.newspaper;

    case 'newspaperClipping':
      return PhosphorIcons.regular.newspaperClipping;

    case 'notches':
      return PhosphorIcons.regular.notches;

    case 'note':
      return PhosphorIcons.regular.note;

    case 'noteBlank':
      return PhosphorIcons.regular.noteBlank;

    case 'notePencil':
      return PhosphorIcons.regular.notePencil;

    case 'notebook':
      return PhosphorIcons.regular.notebook;

    case 'notepad':
      return PhosphorIcons.regular.notepad;

    case 'notification':
      return PhosphorIcons.regular.notification;

    case 'notionLogo':
      return PhosphorIcons.regular.notionLogo;

    case 'numberCircleEight':
      return PhosphorIcons.regular.numberCircleEight;

    case 'numberCircleFive':
      return PhosphorIcons.regular.numberCircleFive;

    case 'numberCircleFour':
      return PhosphorIcons.regular.numberCircleFour;

    case 'numberCircleNine':
      return PhosphorIcons.regular.numberCircleNine;

    case 'numberCircleOne':
      return PhosphorIcons.regular.numberCircleOne;

    case 'numberCircleSeven':
      return PhosphorIcons.regular.numberCircleSeven;

    case 'numberCircleSix':
      return PhosphorIcons.regular.numberCircleSix;

    case 'numberCircleThree':
      return PhosphorIcons.regular.numberCircleThree;

    case 'numberCircleTwo':
      return PhosphorIcons.regular.numberCircleTwo;

    case 'numberCircleZero':
      return PhosphorIcons.regular.numberCircleZero;

    case 'numberEight':
      return PhosphorIcons.regular.numberEight;

    case 'numberFive':
      return PhosphorIcons.regular.numberFive;

    case 'numberFour':
      return PhosphorIcons.regular.numberFour;

    case 'numberNine':
      return PhosphorIcons.regular.numberNine;

    case 'numberOne':
      return PhosphorIcons.regular.numberOne;

    case 'numberSeven':
      return PhosphorIcons.regular.numberSeven;

    case 'numberSix':
      return PhosphorIcons.regular.numberSix;

    case 'numberSquareEight':
      return PhosphorIcons.regular.numberSquareEight;

    case 'numberSquareFive':
      return PhosphorIcons.regular.numberSquareFive;

    case 'numberSquareFour':
      return PhosphorIcons.regular.numberSquareFour;

    case 'numberSquareNine':
      return PhosphorIcons.regular.numberSquareNine;

    case 'numberSquareOne':
      return PhosphorIcons.regular.numberSquareOne;

    case 'numberSquareSeven':
      return PhosphorIcons.regular.numberSquareSeven;

    case 'numberSquareSix':
      return PhosphorIcons.regular.numberSquareSix;

    case 'numberSquareThree':
      return PhosphorIcons.regular.numberSquareThree;

    case 'numberSquareTwo':
      return PhosphorIcons.regular.numberSquareTwo;

    case 'numberSquareZero':
      return PhosphorIcons.regular.numberSquareZero;

    case 'numberThree':
      return PhosphorIcons.regular.numberThree;

    case 'numberTwo':
      return PhosphorIcons.regular.numberTwo;

    case 'numberZero':
      return PhosphorIcons.regular.numberZero;

    case 'nut':
      return PhosphorIcons.regular.nut;

    case 'nyTimesLogo':
      return PhosphorIcons.regular.nyTimesLogo;

    case 'octagon':
      return PhosphorIcons.regular.octagon;

    case 'officeChair':
      return PhosphorIcons.regular.officeChair;

    case 'option':
      return PhosphorIcons.regular.option;

    case 'orangeSlice':
      return PhosphorIcons.regular.orangeSlice;

    case 'package':
      return PhosphorIcons.regular.package;

    case 'paintBrush':
      return PhosphorIcons.regular.paintBrush;

    case 'paintBrushBroad':
      return PhosphorIcons.regular.paintBrushBroad;

    case 'paintBrushHousehold':
      return PhosphorIcons.regular.paintBrushHousehold;

    case 'paintBucket':
      return PhosphorIcons.regular.paintBucket;

    case 'paintRoller':
      return PhosphorIcons.regular.paintRoller;

    case 'palette':
      return PhosphorIcons.regular.palette;

    case 'pants':
      return PhosphorIcons.regular.pants;

    case 'paperPlane':
      return PhosphorIcons.regular.paperPlane;

    case 'paperPlaneRight':
      return PhosphorIcons.regular.paperPlaneRight;

    case 'paperPlaneTilt':
      return PhosphorIcons.regular.paperPlaneTilt;

    case 'paperclip':
      return PhosphorIcons.regular.paperclip;

    case 'paperclipHorizontal':
      return PhosphorIcons.regular.paperclipHorizontal;

    case 'parachute':
      return PhosphorIcons.regular.parachute;

    case 'paragraph':
      return PhosphorIcons.regular.paragraph;

    case 'parallelogram':
      return PhosphorIcons.regular.parallelogram;

    case 'park':
      return PhosphorIcons.regular.park;

    case 'password':
      return PhosphorIcons.regular.password;

    case 'path':
      return PhosphorIcons.regular.path;

    case 'patreonLogo':
      return PhosphorIcons.regular.patreonLogo;

    case 'pause':
      return PhosphorIcons.regular.pause;

    case 'pauseCircle':
      return PhosphorIcons.regular.pauseCircle;

    case 'pawPrint':
      return PhosphorIcons.regular.pawPrint;

    case 'paypalLogo':
      return PhosphorIcons.regular.paypalLogo;

    case 'peace':
      return PhosphorIcons.regular.peace;

    case 'pen':
      return PhosphorIcons.regular.pen;

    case 'penNib':
      return PhosphorIcons.regular.penNib;

    case 'penNibStraight':
      return PhosphorIcons.regular.penNibStraight;

    case 'pencil':
      return PhosphorIcons.regular.pencil;

    case 'pencilCircle':
      return PhosphorIcons.regular.pencilCircle;

    case 'pencilLine':
      return PhosphorIcons.regular.pencilLine;

    case 'pencilSimple':
      return PhosphorIcons.regular.pencilSimple;

    case 'pencilSimpleLine':
      return PhosphorIcons.regular.pencilSimpleLine;

    case 'pencilSimpleSlash':
      return PhosphorIcons.regular.pencilSimpleSlash;

    case 'pencilSlash':
      return PhosphorIcons.regular.pencilSlash;

    case 'pentagram':
      return PhosphorIcons.regular.pentagram;

    case 'pepper':
      return PhosphorIcons.regular.pepper;

    case 'percent':
      return PhosphorIcons.regular.percent;

    case 'person':
      return PhosphorIcons.regular.person;

    case 'personArmsSpread':
      return PhosphorIcons.regular.personArmsSpread;

    case 'personSimple':
      return PhosphorIcons.regular.personSimple;

    case 'personSimpleBike':
      return PhosphorIcons.regular.personSimpleBike;

    case 'personSimpleRun':
      return PhosphorIcons.regular.personSimpleRun;

    case 'personSimpleThrow':
      return PhosphorIcons.regular.personSimpleThrow;

    case 'personSimpleWalk':
      return PhosphorIcons.regular.personSimpleWalk;

    case 'perspective':
      return PhosphorIcons.regular.perspective;

    case 'phone':
      return PhosphorIcons.regular.phone;

    case 'phoneCall':
      return PhosphorIcons.regular.phoneCall;

    case 'phoneDisconnect':
      return PhosphorIcons.regular.phoneDisconnect;

    case 'phoneIncoming':
      return PhosphorIcons.regular.phoneIncoming;

    case 'phoneOutgoing':
      return PhosphorIcons.regular.phoneOutgoing;

    case 'phonePlus':
      return PhosphorIcons.regular.phonePlus;

    case 'phoneSlash':
      return PhosphorIcons.regular.phoneSlash;

    case 'phoneX':
      return PhosphorIcons.regular.phoneX;

    case 'phosphorLogo':
      return PhosphorIcons.regular.phosphorLogo;

    case 'pi':
      return PhosphorIcons.regular.pi;

    case 'pianoKeys':
      return PhosphorIcons.regular.pianoKeys;

    case 'pictureInpicture':
      return PhosphorIcons.regular.pictureInpicture;

    case 'piggyBank':
      return PhosphorIcons.regular.piggyBank;

    case 'pill':
      return PhosphorIcons.regular.pill;

    case 'pinterestLogo':
      return PhosphorIcons.regular.pinterestLogo;

    case 'pinwheel':
      return PhosphorIcons.regular.pinwheel;

    case 'pizza':
      return PhosphorIcons.regular.pizza;

    case 'placeholder':
      return PhosphorIcons.regular.placeholder;

    case 'planet':
      return PhosphorIcons.regular.planet;

    case 'plant':
      return PhosphorIcons.regular.plant;

    case 'play':
      return PhosphorIcons.regular.play;

    case 'playCircle':
      return PhosphorIcons.regular.playCircle;

    case 'playPause':
      return PhosphorIcons.regular.playPause;

    case 'playlist':
      return PhosphorIcons.regular.playlist;

    case 'plug':
      return PhosphorIcons.regular.plug;

    case 'plugCharging':
      return PhosphorIcons.regular.plugCharging;

    case 'plugs':
      return PhosphorIcons.regular.plugs;

    case 'plugsConnected':
      return PhosphorIcons.regular.plugsConnected;

    case 'plus':
      return PhosphorIcons.regular.plus;

    case 'plusCircle':
      return PhosphorIcons.regular.plusCircle;

    case 'plusMinus':
      return PhosphorIcons.regular.plusMinus;

    case 'plusSquare':
      return PhosphorIcons.regular.plusSquare;

    case 'pokerChip':
      return PhosphorIcons.regular.pokerChip;

    case 'policeCar':
      return PhosphorIcons.regular.policeCar;

    case 'polygon':
      return PhosphorIcons.regular.polygon;

    case 'popcorn':
      return PhosphorIcons.regular.popcorn;

    case 'pottedPlant':
      return PhosphorIcons.regular.pottedPlant;

    case 'power':
      return PhosphorIcons.regular.power;

    case 'prescription':
      return PhosphorIcons.regular.prescription;

    case 'presentation':
      return PhosphorIcons.regular.presentation;

    case 'presentationChart':
      return PhosphorIcons.regular.presentationChart;

    case 'printer':
      return PhosphorIcons.regular.printer;

    case 'prohibit':
      return PhosphorIcons.regular.prohibit;

    case 'prohibitInset':
      return PhosphorIcons.regular.prohibitInset;

    case 'projectorScreen':
      return PhosphorIcons.regular.projectorScreen;

    case 'projectorScreenChart':
      return PhosphorIcons.regular.projectorScreenChart;

    case 'pulse':
      return PhosphorIcons.regular.pulse;

    case 'pushPin':
      return PhosphorIcons.regular.pushPin;

    case 'pushPinSimple':
      return PhosphorIcons.regular.pushPinSimple;

    case 'pushPinSimpleSlash':
      return PhosphorIcons.regular.pushPinSimpleSlash;

    case 'pushPinSlash':
      return PhosphorIcons.regular.pushPinSlash;

    case 'puzzlePiece':
      return PhosphorIcons.regular.puzzlePiece;

    case 'qrCode':
      return PhosphorIcons.regular.qrCode;

    case 'question':
      return PhosphorIcons.regular.question;

    case 'queue':
      return PhosphorIcons.regular.queue;

    case 'quotes':
      return PhosphorIcons.regular.quotes;

    case 'radical':
      return PhosphorIcons.regular.radical;

    case 'radio':
      return PhosphorIcons.regular.radio;

    case 'radioButton':
      return PhosphorIcons.regular.radioButton;

    case 'radioactive':
      return PhosphorIcons.regular.radioactive;

    case 'rainbow':
      return PhosphorIcons.regular.rainbow;

    case 'rainbowCloud':
      return PhosphorIcons.regular.rainbowCloud;

    case 'readCvLogo':
      return PhosphorIcons.regular.readCvLogo;

    case 'receipt':
      return PhosphorIcons.regular.receipt;

    case 'receiptX':
      return PhosphorIcons.regular.receiptX;

    case 'record':
      return PhosphorIcons.regular.record;

    case 'rectangle':
      return PhosphorIcons.regular.rectangle;

    case 'recycle':
      return PhosphorIcons.regular.recycle;

    case 'redditLogo':
      return PhosphorIcons.regular.redditLogo;

    case 'repeat':
      return PhosphorIcons.regular.repeat;

    case 'repeatOnce':
      return PhosphorIcons.regular.repeatOnce;

    case 'rewind':
      return PhosphorIcons.regular.rewind;

    case 'rewindCircle':
      return PhosphorIcons.regular.rewindCircle;

    case 'roadHorizon':
      return PhosphorIcons.regular.roadHorizon;

    case 'robot':
      return PhosphorIcons.regular.robot;

    case 'rocket':
      return PhosphorIcons.regular.rocket;

    case 'rocketLaunch':
      return PhosphorIcons.regular.rocketLaunch;

    case 'rows':
      return PhosphorIcons.regular.rows;

    case 'rss':
      return PhosphorIcons.regular.rss;

    case 'rssSimple':
      return PhosphorIcons.regular.rssSimple;

    case 'rug':
      return PhosphorIcons.regular.rug;

    case 'ruler':
      return PhosphorIcons.regular.ruler;

    case 'scales':
      return PhosphorIcons.regular.scales;

    case 'scan':
      return PhosphorIcons.regular.scan;

    case 'scissors':
      return PhosphorIcons.regular.scissors;

    case 'scooter':
      return PhosphorIcons.regular.scooter;

    case 'screencast':
      return PhosphorIcons.regular.screencast;

    case 'scribbleLoop':
      return PhosphorIcons.regular.scribbleLoop;

    case 'scroll':
      return PhosphorIcons.regular.scroll;

    case 'seal':
      return PhosphorIcons.regular.seal;

    case 'sealCheck':
      return PhosphorIcons.regular.sealCheck;

    case 'sealQuestion':
      return PhosphorIcons.regular.sealQuestion;

    case 'sealWarning':
      return PhosphorIcons.regular.sealWarning;

    case 'selection':
      return PhosphorIcons.regular.selection;

    case 'selectionAll':
      return PhosphorIcons.regular.selectionAll;

    case 'selectionBackground':
      return PhosphorIcons.regular.selectionBackground;

    case 'selectionForeground':
      return PhosphorIcons.regular.selectionForeground;

    case 'selectionInverse':
      return PhosphorIcons.regular.selectionInverse;

    case 'selectionPlus':
      return PhosphorIcons.regular.selectionPlus;

    case 'selectionSlash':
      return PhosphorIcons.regular.selectionSlash;

    case 'shapes':
      return PhosphorIcons.regular.shapes;

    case 'share':
      return PhosphorIcons.regular.share;

    case 'shareFat':
      return PhosphorIcons.regular.shareFat;

    case 'shareNetwork':
      return PhosphorIcons.regular.shareNetwork;

    case 'shield':
      return PhosphorIcons.regular.shield;

    case 'shieldCheck':
      return PhosphorIcons.regular.shieldCheck;

    case 'shieldCheckered':
      return PhosphorIcons.regular.shieldCheckered;

    case 'shieldChevron':
      return PhosphorIcons.regular.shieldChevron;

    case 'shieldPlus':
      return PhosphorIcons.regular.shieldPlus;

    case 'shieldSlash':
      return PhosphorIcons.regular.shieldSlash;

    case 'shieldStar':
      return PhosphorIcons.regular.shieldStar;

    case 'shieldWarning':
      return PhosphorIcons.regular.shieldWarning;

    case 'shirtFolded':
      return PhosphorIcons.regular.shirtFolded;

    case 'shootingStar':
      return PhosphorIcons.regular.shootingStar;

    case 'shoppingBag':
      return PhosphorIcons.regular.shoppingBag;

    case 'shoppingBagOpen':
      return PhosphorIcons.regular.shoppingBagOpen;

    case 'shoppingCart':
      return PhosphorIcons.regular.shoppingCart;

    case 'shoppingCartSimple':
      return PhosphorIcons.regular.shoppingCartSimple;

    case 'shower':
      return PhosphorIcons.regular.shower;

    case 'shrimp':
      return PhosphorIcons.regular.shrimp;

    case 'shuffle':
      return PhosphorIcons.regular.shuffle;

    case 'shuffleAngular':
      return PhosphorIcons.regular.shuffleAngular;

    case 'shuffleSimple':
      return PhosphorIcons.regular.shuffleSimple;

    case 'sidebar':
      return PhosphorIcons.regular.sidebar;

    case 'sidebarSimple':
      return PhosphorIcons.regular.sidebarSimple;

    case 'sigma':
      return PhosphorIcons.regular.sigma;

    case 'signIn':
      return PhosphorIcons.regular.signIn;

    case 'signOut':
      return PhosphorIcons.regular.signOut;

    case 'signature':
      return PhosphorIcons.regular.signature;

    case 'signpost':
      return PhosphorIcons.regular.signpost;

    case 'simCard':
      return PhosphorIcons.regular.simCard;

    case 'siren':
      return PhosphorIcons.regular.siren;

    case 'sketchLogo':
      return PhosphorIcons.regular.sketchLogo;

    case 'skipBack':
      return PhosphorIcons.regular.skipBack;

    case 'skipBackCircle':
      return PhosphorIcons.regular.skipBackCircle;

    case 'skipForward':
      return PhosphorIcons.regular.skipForward;

    case 'skipForwardCircle':
      return PhosphorIcons.regular.skipForwardCircle;

    case 'skull':
      return PhosphorIcons.regular.skull;

    case 'slackLogo':
      return PhosphorIcons.regular.slackLogo;

    case 'sliders':
      return PhosphorIcons.regular.sliders;

    case 'slidersHorizontal':
      return PhosphorIcons.regular.slidersHorizontal;

    case 'slideshow':
      return PhosphorIcons.regular.slideshow;

    case 'smiley':
      return PhosphorIcons.regular.smiley;

    case 'smileyAngry':
      return PhosphorIcons.regular.smileyAngry;

    case 'smileyBlank':
      return PhosphorIcons.regular.smileyBlank;

    case 'smileyMeh':
      return PhosphorIcons.regular.smileyMeh;

    case 'smileyNervous':
      return PhosphorIcons.regular.smileyNervous;

    case 'smileySad':
      return PhosphorIcons.regular.smileySad;

    case 'smileySticker':
      return PhosphorIcons.regular.smileySticker;

    case 'smileyWink':
      return PhosphorIcons.regular.smileyWink;

    case 'smileyXEyes':
      return PhosphorIcons.regular.smileyXEyes;

    case 'snapchatLogo':
      return PhosphorIcons.regular.snapchatLogo;

    case 'sneaker':
      return PhosphorIcons.regular.sneaker;

    case 'sneakerMove':
      return PhosphorIcons.regular.sneakerMove;

    case 'snowflake':
      return PhosphorIcons.regular.snowflake;

    case 'soccerBall':
      return PhosphorIcons.regular.soccerBall;

    case 'sortAscending':
      return PhosphorIcons.regular.sortAscending;

    case 'sortDescending':
      return PhosphorIcons.regular.sortDescending;

    case 'soundcloudLogo':
      return PhosphorIcons.regular.soundcloudLogo;

    case 'spade':
      return PhosphorIcons.regular.spade;

    case 'sparkle':
      return PhosphorIcons.regular.sparkle;

    case 'speakerHifi':
      return PhosphorIcons.regular.speakerHifi;

    case 'speakerHigh':
      return PhosphorIcons.regular.speakerHigh;

    case 'speakerLow':
      return PhosphorIcons.regular.speakerLow;

    case 'speakerNone':
      return PhosphorIcons.regular.speakerNone;

    case 'speakerSimpleHigh':
      return PhosphorIcons.regular.speakerSimpleHigh;

    case 'speakerSimpleLow':
      return PhosphorIcons.regular.speakerSimpleLow;

    case 'speakerSimpleNone':
      return PhosphorIcons.regular.speakerSimpleNone;

    case 'speakerSimpleSlash':
      return PhosphorIcons.regular.speakerSimpleSlash;

    case 'speakerSimpleX':
      return PhosphorIcons.regular.speakerSimpleX;

    case 'speakerSlash':
      return PhosphorIcons.regular.speakerSlash;

    case 'speakerX':
      return PhosphorIcons.regular.speakerX;

    case 'spinner':
      return PhosphorIcons.regular.spinner;

    case 'spinnerGap':
      return PhosphorIcons.regular.spinnerGap;

    case 'spiral':
      return PhosphorIcons.regular.spiral;

    case 'splitHorizontal':
      return PhosphorIcons.regular.splitHorizontal;

    case 'splitVertical':
      return PhosphorIcons.regular.splitVertical;

    case 'spotifyLogo':
      return PhosphorIcons.regular.spotifyLogo;

    case 'square':
      return PhosphorIcons.regular.square;

    case 'squareHalf':
      return PhosphorIcons.regular.squareHalf;

    case 'squareHalfBottom':
      return PhosphorIcons.regular.squareHalfBottom;

    case 'squareLogo':
      return PhosphorIcons.regular.squareLogo;

    case 'squareSplitHorizontal':
      return PhosphorIcons.regular.squareSplitHorizontal;

    case 'squareSplitVertical':
      return PhosphorIcons.regular.squareSplitVertical;

    case 'squaresFour':
      return PhosphorIcons.regular.squaresFour;

    case 'stack':
      return PhosphorIcons.regular.stack;

    case 'stackOverflowLogo':
      return PhosphorIcons.regular.stackOverflowLogo;

    case 'stackSimple':
      return PhosphorIcons.regular.stackSimple;

    case 'stairs':
      return PhosphorIcons.regular.stairs;

    case 'stamp':
      return PhosphorIcons.regular.stamp;

    case 'star':
      return PhosphorIcons.regular.star;

    case 'starAndCrescent':
      return PhosphorIcons.regular.starAndCrescent;

    case 'starFour':
      return PhosphorIcons.regular.starFour;

    case 'starHalf':
      return PhosphorIcons.regular.starHalf;

    case 'starOfDavid':
      return PhosphorIcons.regular.starOfDavid;

    case 'steeringWheel':
      return PhosphorIcons.regular.steeringWheel;

    case 'steps':
      return PhosphorIcons.regular.steps;

    case 'stethoscope':
      return PhosphorIcons.regular.stethoscope;

    case 'sticker':
      return PhosphorIcons.regular.sticker;

    case 'stool':
      return PhosphorIcons.regular.stool;

    case 'stop':
      return PhosphorIcons.regular.stop;

    case 'stopCircle':
      return PhosphorIcons.regular.stopCircle;

    case 'storefront':
      return PhosphorIcons.regular.storefront;

    case 'strategy':
      return PhosphorIcons.regular.strategy;

    case 'stripeLogo':
      return PhosphorIcons.regular.stripeLogo;

    case 'student':
      return PhosphorIcons.regular.student;

    case 'subtitles':
      return PhosphorIcons.regular.subtitles;

    case 'subtract':
      return PhosphorIcons.regular.subtract;

    case 'subtractSquare':
      return PhosphorIcons.regular.subtractSquare;

    case 'suitcase':
      return PhosphorIcons.regular.suitcase;

    case 'suitcaseRolling':
      return PhosphorIcons.regular.suitcaseRolling;

    case 'suitcaseSimple':
      return PhosphorIcons.regular.suitcaseSimple;

    case 'sun':
      return PhosphorIcons.regular.sun;

    case 'sunDim':
      return PhosphorIcons.regular.sunDim;

    case 'sunHorizon':
      return PhosphorIcons.regular.sunHorizon;

    case 'sunglasses':
      return PhosphorIcons.regular.sunglasses;

    case 'swap':
      return PhosphorIcons.regular.swap;

    case 'swatches':
      return PhosphorIcons.regular.swatches;

    case 'swimmingPool':
      return PhosphorIcons.regular.swimmingPool;

    case 'sword':
      return PhosphorIcons.regular.sword;

    case 'synagogue':
      return PhosphorIcons.regular.synagogue;

    case 'syringe':
      return PhosphorIcons.regular.syringe;

    case 'tShirt':
      return PhosphorIcons.regular.tShirt;

    case 'table':
      return PhosphorIcons.regular.table;

    case 'tabs':
      return PhosphorIcons.regular.tabs;

    case 'tag':
      return PhosphorIcons.regular.tag;

    case 'tagChevron':
      return PhosphorIcons.regular.tagChevron;

    case 'tagSimple':
      return PhosphorIcons.regular.tagSimple;

    case 'target':
      return PhosphorIcons.regular.target;

    case 'taxi':
      return PhosphorIcons.regular.taxi;

    case 'telegramLogo':
      return PhosphorIcons.regular.telegramLogo;

    case 'television':
      return PhosphorIcons.regular.television;

    case 'televisionSimple':
      return PhosphorIcons.regular.televisionSimple;

    case 'tennisBall':
      return PhosphorIcons.regular.tennisBall;

    case 'tent':
      return PhosphorIcons.regular.tent;

    case 'terminal':
      return PhosphorIcons.regular.terminal;

    case 'terminalWindow':
      return PhosphorIcons.regular.terminalWindow;

    case 'testTube':
      return PhosphorIcons.regular.testTube;

    case 'textAUnderline':
      return PhosphorIcons.regular.textAUnderline;

    case 'textAa':
      return PhosphorIcons.regular.textAa;

    case 'textAlignCenter':
      return PhosphorIcons.regular.textAlignCenter;

    case 'textAlignJustify':
      return PhosphorIcons.regular.textAlignJustify;

    case 'textAlignLeft':
      return PhosphorIcons.regular.textAlignLeft;

    case 'textAlignRight':
      return PhosphorIcons.regular.textAlignRight;

    case 'textB':
      return PhosphorIcons.regular.textB;

    case 'textColumns':
      return PhosphorIcons.regular.textColumns;

    case 'textH':
      return PhosphorIcons.regular.textH;

    case 'textHFive':
      return PhosphorIcons.regular.textHFive;

    case 'textHFour':
      return PhosphorIcons.regular.textHFour;

    case 'textHOne':
      return PhosphorIcons.regular.textHOne;

    case 'textHSix':
      return PhosphorIcons.regular.textHSix;

    case 'textHThree':
      return PhosphorIcons.regular.textHThree;

    case 'textHTwo':
      return PhosphorIcons.regular.textHTwo;

    case 'textIndent':
      return PhosphorIcons.regular.textIndent;

    case 'textItalic':
      return PhosphorIcons.regular.textItalic;

    case 'textOutdent':
      return PhosphorIcons.regular.textOutdent;

    case 'textStrikethrough':
      return PhosphorIcons.regular.textStrikethrough;

    case 'textT':
      return PhosphorIcons.regular.textT;

    case 'textUnderline':
      return PhosphorIcons.regular.textUnderline;

    case 'textbox':
      return PhosphorIcons.regular.textbox;

    case 'thermometer':
      return PhosphorIcons.regular.thermometer;

    case 'thermometerCold':
      return PhosphorIcons.regular.thermometerCold;

    case 'thermometerHot':
      return PhosphorIcons.regular.thermometerHot;

    case 'thermometerSimple':
      return PhosphorIcons.regular.thermometerSimple;

    case 'thumbsDown':
      return PhosphorIcons.regular.thumbsDown;

    case 'thumbsUp':
      return PhosphorIcons.regular.thumbsUp;

    case 'ticket':
      return PhosphorIcons.regular.ticket;

    case 'tidalLogo':
      return PhosphorIcons.regular.tidalLogo;

    case 'tiktokLogo':
      return PhosphorIcons.regular.tiktokLogo;

    case 'timer':
      return PhosphorIcons.regular.timer;

    case 'tipi':
      return PhosphorIcons.regular.tipi;

    case 'toggleLeft':
      return PhosphorIcons.regular.toggleLeft;

    case 'toggleRight':
      return PhosphorIcons.regular.toggleRight;

    case 'toilet':
      return PhosphorIcons.regular.toilet;

    case 'toiletPaper':
      return PhosphorIcons.regular.toiletPaper;

    case 'toolbox':
      return PhosphorIcons.regular.toolbox;

    case 'tooth':
      return PhosphorIcons.regular.tooth;

    case 'tote':
      return PhosphorIcons.regular.tote;

    case 'toteSimple':
      return PhosphorIcons.regular.toteSimple;

    case 'trademark':
      return PhosphorIcons.regular.trademark;

    case 'trademarkRegistered':
      return PhosphorIcons.regular.trademarkRegistered;

    case 'trafficCone':
      return PhosphorIcons.regular.trafficCone;

    case 'trafficSign':
      return PhosphorIcons.regular.trafficSign;

    case 'trafficSignal':
      return PhosphorIcons.regular.trafficSignal;

    case 'train':
      return PhosphorIcons.regular.train;

    case 'trainRegional':
      return PhosphorIcons.regular.trainRegional;

    case 'trainSimple':
      return PhosphorIcons.regular.trainSimple;

    case 'tram':
      return PhosphorIcons.regular.tram;

    case 'translate':
      return PhosphorIcons.regular.translate;

    case 'trash':
      return PhosphorIcons.regular.trash;

    case 'trashSimple':
      return PhosphorIcons.regular.trashSimple;

    case 'tray':
      return PhosphorIcons.regular.tray;

    case 'tree':
      return PhosphorIcons.regular.tree;

    case 'treeEvergreen':
      return PhosphorIcons.regular.treeEvergreen;

    case 'treePalm':
      return PhosphorIcons.regular.treePalm;

    case 'treeStructure':
      return PhosphorIcons.regular.treeStructure;

    case 'trendDown':
      return PhosphorIcons.regular.trendDown;

    case 'trendUp':
      return PhosphorIcons.regular.trendUp;

    case 'triangle':
      return PhosphorIcons.regular.triangle;

    case 'trophy':
      return PhosphorIcons.regular.trophy;

    case 'truck':
      return PhosphorIcons.regular.truck;

    case 'twitchLogo':
      return PhosphorIcons.regular.twitchLogo;

    case 'twitterLogo':
      return PhosphorIcons.regular.twitterLogo;

    case 'umbrella':
      return PhosphorIcons.regular.umbrella;

    case 'umbrellaSimple':
      return PhosphorIcons.regular.umbrellaSimple;

    case 'unite':
      return PhosphorIcons.regular.unite;

    case 'uniteSquare':
      return PhosphorIcons.regular.uniteSquare;

    case 'upload':
      return PhosphorIcons.regular.upload;

    case 'uploadSimple':
      return PhosphorIcons.regular.uploadSimple;

    case 'usb':
      return PhosphorIcons.regular.usb;

    case 'user':
      return PhosphorIcons.regular.user;

    case 'userCircle':
      return PhosphorIcons.regular.userCircle;

    case 'userCircleGear':
      return PhosphorIcons.regular.userCircleGear;

    case 'userCircleMinus':
      return PhosphorIcons.regular.userCircleMinus;

    case 'userCirclePlus':
      return PhosphorIcons.regular.userCirclePlus;

    case 'userFocus':
      return PhosphorIcons.regular.userFocus;

    case 'userGear':
      return PhosphorIcons.regular.userGear;

    case 'userList':
      return PhosphorIcons.regular.userList;

    case 'userMinus':
      return PhosphorIcons.regular.userMinus;

    case 'userPlus':
      return PhosphorIcons.regular.userPlus;

    case 'userRectangle':
      return PhosphorIcons.regular.userRectangle;

    case 'userSquare':
      return PhosphorIcons.regular.userSquare;

    case 'userSwitch':
      return PhosphorIcons.regular.userSwitch;

    case 'users':
      return PhosphorIcons.regular.users;

    case 'usersFour':
      return PhosphorIcons.regular.usersFour;

    case 'usersThree':
      return PhosphorIcons.regular.usersThree;

    case 'van':
      return PhosphorIcons.regular.van;

    case 'vault':
      return PhosphorIcons.regular.vault;

    case 'vibrate':
      return PhosphorIcons.regular.vibrate;

    case 'video':
      return PhosphorIcons.regular.video;

    case 'videoCamera':
      return PhosphorIcons.regular.videoCamera;

    case 'videoCameraSlash':
      return PhosphorIcons.regular.videoCameraSlash;

    case 'vignette':
      return PhosphorIcons.regular.vignette;

    case 'vinylRecord':
      return PhosphorIcons.regular.vinylRecord;

    case 'virtualReality':
      return PhosphorIcons.regular.virtualReality;

    case 'virus':
      return PhosphorIcons.regular.virus;

    case 'voicemail':
      return PhosphorIcons.regular.voicemail;

    case 'volleyball':
      return PhosphorIcons.regular.volleyball;

    case 'wall':
      return PhosphorIcons.regular.wall;

    case 'wallet':
      return PhosphorIcons.regular.wallet;

    case 'warehouse':
      return PhosphorIcons.regular.warehouse;

    case 'warning':
      return PhosphorIcons.regular.warning;

    case 'warningCircle':
      return PhosphorIcons.regular.warningCircle;

    case 'warningDiamond':
      return PhosphorIcons.regular.warningDiamond;

    case 'warningOctagon':
      return PhosphorIcons.regular.warningOctagon;

    case 'watch':
      return PhosphorIcons.regular.watch;

    case 'waveSawtooth':
      return PhosphorIcons.regular.waveSawtooth;

    case 'waveSine':
      return PhosphorIcons.regular.waveSine;

    case 'waveSquare':
      return PhosphorIcons.regular.waveSquare;

    case 'waveTriangle':
      return PhosphorIcons.regular.waveTriangle;

    case 'waveform':
      return PhosphorIcons.regular.waveform;

    case 'waves':
      return PhosphorIcons.regular.waves;

    case 'webcam':
      return PhosphorIcons.regular.webcam;

    case 'webcamSlash':
      return PhosphorIcons.regular.webcamSlash;

    case 'webhooksLogo':
      return PhosphorIcons.regular.webhooksLogo;

    case 'wechatLogo':
      return PhosphorIcons.regular.wechatLogo;

    case 'whatsappLogo':
      return PhosphorIcons.regular.whatsappLogo;

    case 'wheelchair':
      return PhosphorIcons.regular.wheelchair;

    case 'wheelchairMotion':
      return PhosphorIcons.regular.wheelchairMotion;

    case 'wifiHigh':
      return PhosphorIcons.regular.wifiHigh;

    case 'wifiLow':
      return PhosphorIcons.regular.wifiLow;

    case 'wifiMedium':
      return PhosphorIcons.regular.wifiMedium;

    case 'wifiNone':
      return PhosphorIcons.regular.wifiNone;

    case 'wifiSlash':
      return PhosphorIcons.regular.wifiSlash;

    case 'wifiX':
      return PhosphorIcons.regular.wifiX;

    case 'wind':
      return PhosphorIcons.regular.wind;

    case 'windowsLogo':
      return PhosphorIcons.regular.windowsLogo;

    case 'wine':
      return PhosphorIcons.regular.wine;

    case 'wrench':
      return PhosphorIcons.regular.wrench;

    case 'x':
      return PhosphorIcons.regular.x;

    case 'xCircle':
      return PhosphorIcons.regular.xCircle;

    case 'xSquare':
      return PhosphorIcons.regular.xSquare;

    case 'yinYang':
      return PhosphorIcons.regular.yinYang;

    case 'youtubeLogo':
      return PhosphorIcons.regular.youtubeLogo;

    default:
      return PhosphorIcons.regular.info;
  }
}
