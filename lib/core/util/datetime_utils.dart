class DatetimeUtils {
  static DateTime fromTimestamp(int timestamp) {
    if (timestamp.toString().length <= 10) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    }
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  static String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inSeconds < 60) {
      return 'agora';
    } else if (diff.inMinutes < 60) {
      return 'há ${diff.inMinutes} min';
    } else if (diff.inHours < 24) {
      return 'há ${diff.inHours} h';
    } else if (diff.inDays < 7) {
      return 'há ${diff.inDays} dias';
    } else {
      return formatDate(date);
    }
  }

  /// Formata data: 28/01/2026
  static String formatDate(DateTime date) {
    date = date.toLocal();
    return '${_two(date.day)}/${_two(date.month)}/${date.year}';
  }

  /// Formata day: 28/01 or hoje
  static String formatDay(DateTime date) {
    date = date.toLocal();
    final now = DateTime.now();
    if (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day) {
      return 'Hoje';
    }
    final yesterday = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 1));
    if (yesterday.year == date.year &&
        yesterday.month == date.month &&
        yesterday.day == date.day) {
      return 'Ontem';
    }
    return '${_two(date.day)}/${_two(date.month)}';
  }

  /// Formata hora: 14:32
  static String formatTime(DateTime date) {
    date = date.toLocal();
    return '${_two(date.hour)}:${_two(date.minute)}';
  }

  /// Data + hora: 28/01/2026 às 14:32
  static String formatDateTime(DateTime date) {
    date = date.toLocal();
    return '${formatDate(date)} às ${formatTime(date)}';
  }

  /// Dia + hora: 28/01 às 14:32
  static String formatDayTime(DateTime date) {
    date = date.toLocal();
    return '${formatDay(date)} às ${formatTime(date)}';
  }

  static String timestampToDateTime(int timestamp) {
    final date = fromTimestamp(timestamp);
    return '${formatDate(date)} às ${formatTime(date)}';
  }

  static String _two(int value) => value.toString().padLeft(2, '0');
}
