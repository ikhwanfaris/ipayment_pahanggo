enum CartItemTypeEnum {
  BILL,
  SERVICE;

  String value() {
    switch (this) {
      case BILL:
        return 'bill';
      case SERVICE:
        return 'service';
      default:
        throw ArgumentError('Invalid cart item type enum');
    }
  }

  factory CartItemTypeEnum.from(String value) {
    switch (value) {
      case 'bill':
        return BILL;
      case 'service':
        return SERVICE;
      default:
        throw ArgumentError('Invalid cart item type value');
    }
  }
}
