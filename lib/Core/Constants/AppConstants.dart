class AppConstants {
  static const String appName = 'Tidyo';
  
  static const String defaultStoragePath = '/storage/emulated/0';

  static const List<String> junkExtensions = [
    '.tmp',
    '.temp',
    '.log',
    '.cache',
    '.old',
    '.bak',
    '.dmp',
  ];

  static const List<String> cacheFolderNames = [
    'cache',
    'caches',
    'Cache',
    '.thumbnails',
    '.trash',
  ];

  static const List<String> protectedFolders = [
    'DCIM',
    'Camera',
    'Documents',
    'Download',
    'Pictures',
    'Movies',
    'Music',
  ];
}
