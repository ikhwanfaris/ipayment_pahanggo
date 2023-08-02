import 'package:json_annotation/json_annotation.dart';

enum BillTypeEnum {
  @JsonValue(1)
  BILL,
  @JsonValue(2)
  BIL_TANPA_AMAUN,
  @JsonValue(3)
  BAYARAN_TANPA_BIL,
  @JsonValue(4)
  BAYARAN_TANPA_BIL_DAN_AMAUN,
  @JsonValue(5)
  BAYARAN_TANPA_KADAR;

  int value() {
    switch (this) {
      case BIL_TANPA_AMAUN:
        return 2;
      case BAYARAN_TANPA_BIL:
        return 3;
      case BAYARAN_TANPA_BIL_DAN_AMAUN:
        return 4;
      case BAYARAN_TANPA_KADAR:
        return 5;
      default:
        return 1;
    }
  }

  factory BillTypeEnum.from(int value) {
    switch (value) {
      case 2:
        return BIL_TANPA_AMAUN;
      case 3:
        return BAYARAN_TANPA_BIL;
      case 4:
        return BAYARAN_TANPA_BIL_DAN_AMAUN;
      case 5:
        return BAYARAN_TANPA_KADAR;
      default:
        return BILL;
    }
  }
}
