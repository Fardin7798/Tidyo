import 'JunkItemModel.dart';

class JunkCategoryModel {
  final String title;
  final String tag;
  final JunkTier tier;
  final List<JunkItemModel> items;

  JunkCategoryModel({
    required this.title,
    required this.tag,
    required this.tier,
    required this.items,
  });

  int get totalBytes => items.fold(0, (sum, item) => sum + item.sizeBytes);

  int get selectedBytes => items
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + item.sizeBytes);

  String get formattedTotalSize => _format(totalBytes);
  String get formattedSelectedSize => _format(selectedBytes);

  static String _format(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}
