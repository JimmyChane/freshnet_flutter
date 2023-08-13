class PhoneNumber {
  String value = '';

  fromData(data) {
    value = data;

    return this;
  }

  @override
  String toString() {
    String spliceString(String text, int index, {int count = 1}) {
      if (count <= 0) return text;
      if (index == 0) return text.substring(index + count);
      if (text.length <= index + count) return text.substring(0, index);
      return text.substring(0, index) + text.substring(index + count);
    }

    for (int i = 0; i < value.length; i++) {
      String char = value[i];
      int? number = int.tryParse(char);
      if (number == null) {
        value = spliceString(value, i);
        i--;
      }
    }

    return value;
  }
}
