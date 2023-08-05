import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate => DateFormat('dd/MM/yyyy').format(this);

  String get formattedTime => DateFormat('HH:mm').format(this);

  String get formattedDateTime => DateFormat('dd/MM/yyyy HH:mm').format(this);

  String get relativeDays {
    final diffDays = difference(DateTime.now()).inDays;
    final isNegative = diffDays.isNegative;

    final checkCondition = (diffDays, isNegative);
    return switch (checkCondition) { (0, _) => _tillToday, (_, true) => _dayPassed, _ => _dayLeft };
  }

  String get _dayLeft =>
      'daysLeft'.tr(namedArgs: {"daysCount": difference(DateTime.now()).inDays.toString()});

  String get _dayPassed =>
      'daysPassed'.tr(namedArgs: {"daysCount": difference(DateTime.now()).inDays.abs().toString()});

  String get _tillToday => 'tillToday'.tr();
}
