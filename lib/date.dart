import 'package:intl/intl.dart';

String formatSimpleDate(DateTime date) {
  return DateFormat("yyyy. MM. dd.").format(date);
}

String formatHumanDate(DateTime date) {
  final now = DateTime.now();

  final diff = now.difference(date);

  if (now.year != date.year) {
    return DateFormat("yyyy년 MM월").format(date);
  }

  if (diff.inDays > 6) {
    return DateFormat("M월 D일").format(date);
  }

  if (diff.inDays == 1) {
    return "어제";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays}일 전";
  }

  if (diff.inHours > 0) {
    return "${diff.inHours}시간 전";
  }

  if (diff.inMinutes > 0) {
    return "${diff.inMinutes}분 전";
  }

  return "방금 전";
}
