class ResidualFolderEntity {
  final String path;
  final double mb;
  final List<(String, String)> subs;

  const ResidualFolderEntity({
    required this.path,
    required this.mb,
    this.subs = const [],
  });
}
