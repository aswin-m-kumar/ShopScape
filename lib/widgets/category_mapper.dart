String mapCategoryLabel(String rawCategory, {String? title}) {
  final category = rawCategory.trim().toLowerCase();
  final titleLower = title?.toLowerCase() ?? '';

  if (category == 'electronics') {
    if (_containsAudioKeyword(titleLower)) {
      return 'Audio';
    }
    return 'Tech';
  }

  if (category == "men's clothing" || category == "women's clothing") {
    return 'Apparel';
  }

  if (category == 'jewelery') {
    return 'Apparel';
  }

  return _titleCase(rawCategory);
}

String formatCategoryHeader(String rawCategory) {
  return _titleCase(rawCategory);
}

bool _containsAudioKeyword(String value) {
  return value.contains('headphone') ||
      value.contains('earbud') ||
      value.contains('earphone') ||
      value.contains('speaker') ||
      value.contains('audio') ||
      value.contains('sound') ||
      value.contains('mic');
}

String _titleCase(String input) {
  return input
      .split(' ')
      .where((part) => part.trim().isNotEmpty)
      .map((part) {
    final trimmed = part.trim();
    if (trimmed.isEmpty) {
      return trimmed;
    }
    final first = trimmed[0].toUpperCase();
    final rest = trimmed.length > 1 ? trimmed.substring(1).toLowerCase() : '';
    return '$first$rest';
  }).join(' ');
}
