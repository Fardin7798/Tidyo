class StorageInfoModel {
  final int totalBytes;
  final int usedBytes;
  final int freeBytes;

  const StorageInfoModel({
    required this.totalBytes,
    required this.usedBytes,
    required this.freeBytes,
  });

  double get usedPercentage {
    if (totalBytes == 0) return 0.0;
    return (usedBytes / totalBytes) * 100;
  }

  double get ratio {
    if (totalBytes == 0) return 0.0;
    return (usedBytes / totalBytes).clamp(0.0, 1.0);
  }

  String get formattedTotal => _formatBytes(totalBytes);
  String get formattedUsed => _formatBytes(usedBytes);
  String get formattedFree => _formatBytes(freeBytes);

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
