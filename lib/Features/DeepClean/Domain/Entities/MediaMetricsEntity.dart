class MediaMetricsEntity {
  final int whatsappBytes;
  final int telegramBytes;
  final int browserBytes;

  const MediaMetricsEntity({
    required this.whatsappBytes,
    required this.telegramBytes,
    required this.browserBytes,
  });

  int get totalBytes => whatsappBytes + telegramBytes + browserBytes;
}
