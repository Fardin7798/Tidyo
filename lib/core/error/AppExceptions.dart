class StorageException implements Exception {
  final String message;
  const StorageException(this.message);

  @override
  String toString() => 'StorageException: $message';
}

class PermissionDeniedException implements Exception {
  final String message;
  const PermissionDeniedException([this.message = 'Permission denied']);

  @override
  String toString() => 'PermissionDeniedException: $message';
}

class ScanException implements Exception {
  final String message;
  const ScanException(this.message);

  @override
  String toString() => 'ScanException: $message';
}

class DeleteException implements Exception {
  final String message;
  const DeleteException(this.message);

  @override
  String toString() => 'DeleteException: $message';
}
