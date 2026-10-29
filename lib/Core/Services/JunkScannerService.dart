import 'dart:io';
import '../Models/JunkItemModel.dart';

class BigFileModel {
  final String name;
  final String path;
  final int sizeBytes;

  const BigFileModel({
    required this.name,
    required this.path,
    required this.sizeBytes,
  });

  String get formattedSize {
    if (sizeBytes < 1024 * 1024) {
      return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    }
    if (sizeBytes < 1024 * 1024 * 1024) {
      return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(sizeBytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

class JunkScannerService {
  bool _isCancelled = false;

  void stopScan() {
    _isCancelled = true;
  }

  Future<List<JunkItemModel>> scanAll({
    void Function(String currentPath, int fileCount, int totalBytesFound)? onProgress,
  }) async {
    _isCancelled = false;
    final items = <JunkItemModel>[];
    int fileCount = 0;
    int totalBytes = 0;

    final root = Directory('/storage/emulated/0');
    if (!await root.exists()) {
      return items;
    }

    try {
      final entities = root.listSync(followLinks: false);
      for (final entity in entities) {
        if (_isCancelled) break;
        final name = entity.path.split('/').last.toLowerCase();

        if (entity is Directory) {
          if (name == 'android') {
            await _scanAndroidMedia(entity, items, (p, c, b) {
              fileCount += c;
              totalBytes += b;
              onProgress?.call(p, fileCount, totalBytes);
            });
          } else if (!name.startsWith('.')) {
            await _scanSubDir(entity, items, 0, (p, c, b) {
              fileCount += c;
              totalBytes += b;
              onProgress?.call(p, fileCount, totalBytes);
            });
          }
        }
      }
    } catch (_) {}

    return items;
  }

  Future<void> _scanSubDir(
    Directory dir,
    List<JunkItemModel> items,
    int depth,
    void Function(String path, int count, int bytes) onProg,
  ) async {
    if (depth > 6 || _isCancelled) return;

    try {
      final list = dir.listSync(followLinks: false);
      if (list.isEmpty && depth > 0) {
        final name = dir.path.split('/').last;
        if (!dir.path.contains('/DCIM') && !dir.path.contains('/Download')) {
          items.add(
            JunkItemModel(
              path: dir.path,
              name: name,
              sizeBytes: 0,
              tier: JunkTier.safe,
              categoryName: 'Empty folders',
            ),
          );
          onProg(dir.path, 1, 0);
        }
        return;
      }

      for (final f in list) {
        if (_isCancelled) break;
        final name = f.path.split('/').last.toLowerCase();

        if (f is Directory) {
          if (name == '.thumbnails' || name == '.cache') {
            final size = _dirSize(f);
            items.add(
              JunkItemModel(
                path: f.path,
                name: f.path.split('/').last,
                sizeBytes: size,
                tier: JunkTier.safe,
                categoryName: 'Cache & temp',
              ),
            );
            onProg(f.path, 1, size);
          } else if (!name.startsWith('.')) {
            await _scanSubDir(f, items, depth + 1, onProg);
          }
        } else if (f is File) {
          final size = f.lengthSync();
          if (name.endsWith('.tmp') || name.endsWith('.temp')) {
            items.add(
              JunkItemModel(
                path: f.path,
                name: f.path.split('/').last,
                sizeBytes: size,
                tier: JunkTier.safe,
                categoryName: 'Cache & temp',
              ),
            );
            onProg(f.path, 1, size);
          } else if (name.endsWith('.log') || name.endsWith('.crashlog')) {
            items.add(
              JunkItemModel(
                path: f.path,
                name: f.path.split('/').last,
                sizeBytes: size,
                tier: JunkTier.safe,
                categoryName: 'App logs',
              ),
            );
            onProg(f.path, 1, size);
          } else if (name.endsWith('.apk') && !f.path.contains('/Download/')) {
            items.add(
              JunkItemModel(
                path: f.path,
                name: f.path.split('/').last,
                sizeBytes: size,
                tier: JunkTier.safe,
                categoryName: 'Old APK installers',
              ),
            );
            onProg(f.path, 1, size);
          } else {
            onProg(f.path, 1, 0);
          }
        }
      }
    } catch (_) {}
  }

  Future<void> _scanAndroidMedia(
    Directory androidDir,
    List<JunkItemModel> items,
    void Function(String path, int count, int bytes) onProg,
  ) async {
    final mediaDir = Directory('${androidDir.path}/media/com.whatsapp/WhatsApp/Media');
    if (await mediaDir.exists()) {
      try {
        final vn = Directory('${mediaDir.path}/WhatsApp Voice Notes');
        if (await vn.exists()) {
          final sz = _dirSize(vn);
          items.add(
            JunkItemModel(
              path: vn.path,
              name: 'WhatsApp stickers & voice',
              sizeBytes: sz,
              tier: JunkTier.review,
              categoryName: 'WhatsApp stickers & voice',
              isSelected: false,
            ),
          );
          onProg(vn.path, 1, sz);
        }
      } catch (_) {}
    }
  }

  int _dirSize(Directory d) {
    int total = 0;
    try {
      for (final f in d.listSync(recursive: true, followLinks: false)) {
        if (f is File) total += f.lengthSync();
      }
    } catch (_) {}
    return total;
  }

  Future<int> deleteItems(List<JunkItemModel> items) async {
    int deletedBytes = 0;
    for (final item in items) {
      if (!item.isSelected || item.tier == JunkTier.locked) continue;
      try {
        final t = FileSystemEntity.typeSync(item.path);
        if (t == FileSystemEntityType.directory) {
          final d = Directory(item.path);
          if (await d.exists()) {
            await d.delete(recursive: true);
            deletedBytes += item.sizeBytes;
          }
        } else if (t == FileSystemEntityType.file) {
          final f = File(item.path);
          if (await f.exists()) {
            await f.delete();
            deletedBytes += item.sizeBytes;
          }
        }
      } catch (_) {}
    }
    return deletedBytes;
  }

  Future<List<BigFileModel>> findBigFiles({int minBytes = 25 * 1024 * 1024}) async {
    final results = <BigFileModel>[];
    final root = Directory('/storage/emulated/0');
    if (!await root.exists()) return results;

    final targetDirs = [
      Directory('/storage/emulated/0/Download'),
      Directory('/storage/emulated/0/DCIM'),
      Directory('/storage/emulated/0/Movies'),
      Directory('/storage/emulated/0/Pictures'),
      Directory('/storage/emulated/0/Music'),
      Directory('/storage/emulated/0/Documents'),
    ];

    try {
      for (final entity in root.listSync(followLinks: false)) {
        if (entity is Directory) {
          final n = entity.path.split('/').last;
          if (n != 'Android' && !n.startsWith('.') && !targetDirs.any((d) => d.path == entity.path)) {
            targetDirs.add(entity);
          }
        }
      }
    } catch (_) {}

    for (final dir in targetDirs) {
      if (!dir.existsSync()) continue;
      _collectBigFilesInDir(dir, results, minBytes, 0);
    }

    results.sort((a, b) => b.sizeBytes.compareTo(a.sizeBytes));
    return results;
  }

  void _collectBigFilesInDir(Directory dir, List<BigFileModel> results, int minBytes, int depth) {
    if (depth > 5) return;
    try {
      for (final entity in dir.listSync(followLinks: false)) {
        if (entity is File) {
          try {
            final len = entity.lengthSync();
            if (len >= minBytes) {
              results.add(
                BigFileModel(
                  name: entity.path.split('/').last,
                  path: entity.path,
                  sizeBytes: len,
                ),
              );
            }
          } catch (_) {}
        } else if (entity is Directory) {
          final name = entity.path.split('/').last;
          if (!name.startsWith('.') && name != 'Android') {
            _collectBigFilesInDir(entity, results, minBytes, depth + 1);
          }
        }
      }
    } catch (_) {}
  }
}
