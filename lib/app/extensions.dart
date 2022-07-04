extension NunNullString on String? {
  String orNull() {
    if (this == null) {
      return '';
    } else {
      return this!;
    }
  }
}

extension NunNullInteger on int? {
  int orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}
