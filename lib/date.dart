import 'package:intl/intl.dart';

String formatDateString(String date) {
  return formatDateTime(DateTime.parse(date).toLocal());
}

String formatDateTime(DateTime date) {
  return DateFormat('yyyy.MM.dd a hh:mm').format(date).replaceAll('PM', '오후').replaceAll('AM', '오전');
}

String formatTime(DateTime date) {
  return DateFormat('a hh:mm').format(date).replaceAll('PM', '오후').replaceAll('AM', '오전');
}

String formatSimpleDate(DateTime date) {
  return DateFormat("yyyy. MM. dd.").format(date);
}

String formatSimpleDateTime(DateTime date) {
  final now = DateTime.now();

  if (now.year != date.year) {
    return DateFormat("yyyy년 M월 d일").format(date);
  }

  if (now.month != date.month || now.day != date.day) {
    return DateFormat("M월 d일").format(date);
  }

  return DateFormat("a h:mm").format(date).replaceAll('PM', '오후').replaceAll('AM', '오전');
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
