import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> hasStoragePermission() async {
    if (!Platform.isAndroid) {
      return true;
    }
    
    if (await Permission.manageExternalStorage.isGranted) {
      return true;
    }

    final storageStatus = await Permission.storage.status;
    return storageStatus.isGranted;
  }

  Future<bool> requestStoragePermission() async {
    if (!Platform.isAndroid) {
      return true;
    }

    final manageStatus = await Permission.manageExternalStorage.request();
    if (manageStatus.isGranted) {
      return true;
    }

    final storageStatus = await Permission.storage.request();
    return storageStatus.isGranted;
  }
}
