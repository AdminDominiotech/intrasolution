extension ListGenerate on List {
  List<int> intGenerate(int min, int max) => _Extensor.intGenerate(min, max);
}

extension ListUpdate<T> on List<T> {
  List<T> update(int pos, T t) {
    var list = List<T>.from([])..add(t);
    replaceRange(pos, pos + 1, list);
    return this;
  }
}

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension DateFormat on DateTime {
  String get formatFech => _Extensor.formatFech(this);
  String get formatLocalFech => _Extensor.formatLocalFech(this);
  String get formatHour => _Extensor.formatHour(this);
  String get localMonth => _Extensor.localMonth(this);
  String get completeMonth => _Extensor.completeMonth(this);
  String get localDay => _Extensor.localDay(weekday);
}

extension IntFormat on int {
  String get localWeekday => _Extensor.localWeekday(this);
}

extension StringFormat on String {
  DateTime get formatLocal => _Extensor.formatFromLocal(this);
}

extension Validator on String {
  bool get isText => _Extensor.isTextEs(this);
  bool get isEMail => _Extensor.isEmail(this);
  bool get isPass => _Extensor.isPass(this);
  bool get haveContinuousSpaces => _Extensor.haveContinuousSpaces(this);
  bool isMaxlength(int b) => _Extensor.maxlength(this, b);
  bool get isDecimal => _Extensor.isDecimal(this);
}

class _Extensor {
  static List<int> intGenerate(int min, int max) {
    return List.generate(((max + 1) - min), (i) => min + i);
  }

  static String formatFech(DateTime now) {
    final day = (now.day < 10) ? '0${now.day}' : now.day.toString();
    final month = (now.month < 10) ? '0${now.month}' : now.month.toString();
    final year = now.year.toString();
    return '$year-$month-$day';
  }

  static String formatLocalFech(DateTime now) {
    final day = (now.day < 10) ? '0${now.day}' : now.day.toString();
    final month = (now.month < 10) ? '0${now.month}' : now.month.toString();
    final year = now.year.toString();
    return '$day/$month/$year';
  }

  static String formatHour(DateTime now) {
    final hour = (now.hour < 10) ? '0${now.hour}' : now.hour.toString();
    final minute = (now.minute < 10) ? '0${now.minute}' : now.minute.toString();
    final second = (now.second < 10) ? '0${now.second}' : now.second.toString();
    return '$hour:$minute:$second';
  }

  static bool isPass(String string) {
    var regExp =
        RegExp(r'(?=\w*[0-9]{1,})(?=\w*[A-Z]{1,})(?=\w*[a-z]{1,})\S{8,15}');
    return regExp.hasMatch(string);
  }

  static bool isEmail(String string) {
    var regExp = RegExp(
        r'^([a-zA-Z0-9._-]{2,})@((\[[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}])|(([a-zA-Z\-0–9]{2,}\.)+[a-zA-Z]{2,}))$');
    return regExp.hasMatch(string);
  }

  static bool isTextEs(String string) {
    var regExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚ ]{2,200}$');
    return regExp.hasMatch(string);
  }

  static bool haveContinuousSpaces(String string) {
    var regExp = RegExp(r'\s{2,}');
    return regExp.hasMatch(string);
  }

  static bool maxlength(String string, int max) => (string.length > max);

  static bool isDecimal(String string) {
    var regExp = RegExp(r'^[0-9]+([.][0-9]{1,2})?$');
    return regExp.hasMatch(string);
  }

  static String completeMonth(DateTime d) {
    String s;
    switch (d.month) {
      case 1:
        s = 'Enero';
        break;
      case 2:
        s = 'Febrero';
        break;
      case 3:
        s = 'Marzo';
        break;
      case 4:
        s = 'Abril';
        break;
      case 5:
        s = 'Mayo';
        break;
      case 6:
        s = 'Junio';
        break;
      case 7:
        s = 'Julio';
        break;
      case 8:
        s = 'Agosto';
        break;
      case 9:
        s = 'Septiembre';
        break;
      case 10:
        s = 'Octubre';
        break;
      case 11:
        s = 'Noviembre';
        break;
      case 12:
        s = 'Diciembre';
        break;
      default:
        s = '';
        break;
    }
    return s;
  }

  static String localWeekday(int weekday) {
    String s;
    switch (weekday) {
      case 1:
        s = 'L';
        break;
      case 2:
        s = 'M';
        break;
      case 3:
        s = 'M';
        break;
      case 4:
        s = 'J';
        break;
      case 5:
        s = 'V';
        break;
      case 6:
        s = 'S';
        break;
      case 0:
        s = 'D';
        break;
      default:
        s = '';
        break;
    }
    return s;
  }

  static String localDay(int weekday) {
    String s;
    switch (weekday) {
      case 1:
        s = 'Lun';
        break;
      case 2:
        s = 'Mar';
        break;
      case 3:
        s = 'Mié';
        break;
      case 4:
        s = 'Jue';
        break;
      case 5:
        s = 'Vie';
        break;
      case 6:
        s = 'Sáb';
        break;
      case 7:
        s = 'Dom';
        break;
      default:
        s = '';
        break;
    }
    return s;
  }

  static String localMonth(DateTime d) {
    String s;
    switch (d.month) {
      case 1:
        s = 'Ene';
        break;
      case 2:
        s = 'Feb';
        break;
      case 3:
        s = 'Mar';
        break;
      case 4:
        s = 'Abr';
        break;
      case 5:
        s = 'May';
        break;
      case 6:
        s = 'Jun';
        break;
      case 7:
        s = 'Jul';
        break;
      case 8:
        s = 'Ago';
        break;
      case 9:
        s = 'Sep';
        break;
      case 10:
        s = 'Oct';
        break;
      case 11:
        s = 'Nov';
        break;
      case 12:
        s = 'Dic';
        break;
      default:
        s = '';
        break;
    }
    return s;
  }

  static DateTime formatFromLocal(String? date) {
    if (date == null) throw ArgumentError.notNull();
    if (!date.contains('/') || date.length < 10) {
      throw const FormatException('Este no es el formato esperado');
    }
    return DateTime(int.parse(date.substring(6)),
        int.parse(date.substring(3, 5)), int.parse(date.substring(0, 2)));
  }
}
