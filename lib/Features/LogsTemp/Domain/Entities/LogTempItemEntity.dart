class LogTempItemEntity {
  final String name;
  final String dir;
  final String size;
  final String date;
  final double mb;
  final List<String> previewLines;

  const LogTempItemEntity({
    required this.name,
    required this.dir,
    required this.size,
    required this.date,
    required this.mb,
    this.previewLines = const [],
  });
}
