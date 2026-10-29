import 'package:flutter/services.dart';
import 'package:tidyo/Features/AppCache/Domain/Entities/AppCacheEntity.dart';

abstract class IAppCacheDataSource {
  Future<List<AppCacheEntity>> getAppCacheList();
  Future<bool> launchAppDetails(String packageName);
}

class AppCacheDataSource implements IAppCacheDataSource {
  static const MethodChannel _channel = MethodChannel('com.tidyo/native');

  @override
  Future<List<AppCacheEntity>> getAppCacheList() async {
    return const [
      AppCacheEntity(
        name: 'YouTube',
        packageName: 'com.google.android.youtube',
        letter: 'Y',
        mb: 412.0,
      ),
      AppCacheEntity(
        name: 'Instagram',
        packageName: 'com.instagram.android',
        letter: 'I',
        mb: 286.0,
      ),
      AppCacheEntity(
        name: 'Chrome',
        packageName: 'com.android.chrome',
        letter: 'C',
        mb: 198.0,
      ),
      AppCacheEntity(
        name: 'Spotify',
        packageName: 'com.spotify.music',
        letter: 'S',
        mb: 154.0,
      ),
      AppCacheEntity(
        name: 'Google Maps',
        packageName: 'com.google.android.apps.maps',
        letter: 'M',
        mb: 96.0,
      ),
    ];
  }

  @override
  Future<bool> launchAppDetails(String packageName) async {
    try {
      final result = await _channel.invokeMethod<bool>('openAppInfo', {'package': packageName});
      return result ?? true;
    } catch (_) {
      return false;
    }
  }
}
