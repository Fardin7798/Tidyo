class StoragePartitionEntity {
  final int totalBytes;
  final int freeBytes;
  final int usedBytes;

  const StoragePartitionEntity({
    required this.totalBytes,
    required this.freeBytes,
    required this.usedBytes,
  });

  double get usedPercentage {
    if (totalBytes <= 0) return 0.0;
    return (usedBytes / totalBytes) * 100.0;
  }
}
