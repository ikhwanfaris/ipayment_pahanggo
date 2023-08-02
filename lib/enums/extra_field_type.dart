enum ExtraFieldType {
  text,
  textarea,
  number,
  currency,
  date;

  factory ExtraFieldType.from(String any) {
    switch (any) {
      case 'text':
        return text;
      case 'textarea':
        return textarea;
      case 'number':
        return number;
      case 'currency':
        return currency;
      case 'date':
        return date;
      default:
        throw new Exception('Invalid extra field type');
    }
  }
}
