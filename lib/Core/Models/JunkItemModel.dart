enum JunkTier { safe, review, locked }

class JunkItemModel {
  final String path;
  final String name;
  final int sizeBytes;
  final JunkTier tier;
  final String categoryName;
  bool isSelected;

  JunkItemModel({
    required this.path,
    required this.name,
    required this.sizeBytes,
    required this.tier,
    required this.categoryName,
    this.isSelected = true,
  });

  String get formattedSize {
    if (sizeBytes < 1024) return '$sizeBytes B';
    if (sizeBytes < 1024 * 1024) {
      return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    }
    if (sizeBytes < 1024 * 1024 * 1024) {
      return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(sizeBytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}
