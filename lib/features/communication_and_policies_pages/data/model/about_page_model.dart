import 'dart:ui';

class AboutPageModel {
  const AboutPageModel({
    required this.id,
    required this.titleText,
    required this.titleTextEn,
    required this.contentText,
    required this.contentTextEn,
    this.lastModified,
  });

  final int id;
  final String titleText;
  final String titleTextEn;
  final String contentText;
  final String contentTextEn;
  final DateTime? lastModified;

  factory AboutPageModel.fromJson(Map<String, dynamic> json) {
    return AboutPageModel(
      id: _readInt(json['id']),
      titleText: _readString(json['titletext']),
      titleTextEn: _readString(json['titletexten']),
      contentText: _readString(json['contenttext']),
      contentTextEn: _readString(json['contenttexten']),
      lastModified: DateTime.tryParse(_readString(json['lastmodified'])),
    );
  }

  String localizedTitle(Locale locale) {
    return _localizedValue(
      isArabic: locale.languageCode.toLowerCase() == 'ar',
      arabic: titleText,
      english: titleTextEn,
    );
  }

  String localizedContent(Locale locale) {
    return _localizedValue(
      isArabic: locale.languageCode.toLowerCase() == 'ar',
      arabic: contentText,
      english: contentTextEn,
    );
  }

  static String _localizedValue({
    required bool isArabic,
    required String arabic,
    required String english,
  }) {
    final preferred = isArabic ? arabic : english;
    final fallback = isArabic ? english : arabic;
    return preferred.isNotEmpty ? preferred : fallback;
  }

  static String _readString(dynamic value) => value?.toString().trim() ?? '';

  static int _readInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
