import 'dart:io';
import 'package:tidyo/Features/ResidualFiles/Domain/Entities/ResidualFolderEntity.dart';

abstract class IResidualFilesDataSource {
  Future<List<ResidualFolderEntity>> getResidualFolders();
  Future<bool> deleteResidualFolder(String path);
}

class ResidualFilesDataSource implements IResidualFilesDataSource {
  @override
  Future<List<ResidualFolderEntity>> getResidualFolders() async {
    return const [
      ResidualFolderEntity(
        path: '/Android/data/com.oldgame.app',
        mb: 85,
      ),
      ResidualFolderEntity(
        path: '/Android/data/com.photoedit.pro',
        mb: 35,
        subs: [('cache', '18 MB'), ('files', '12 MB'), ('obb', '5 MB')],
      ),
      ResidualFolderEntity(
        path: '/Android/media/com.vpn.free',
        mb: 14,
      ),
      ResidualFolderEntity(
        path: '/Android/obb/com.shopkart',
        mb: 12,
      ),
    ];
  }

  @override
  Future<bool> deleteResidualFolder(String path) async {
    try {
      final fullPath = path.startsWith('/storage')
          ? path
          : '/storage/emulated/0$path';
      final dir = Directory(fullPath);
      if (await dir.exists()) {
        await dir.delete(recursive: true);
        return true;
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}
