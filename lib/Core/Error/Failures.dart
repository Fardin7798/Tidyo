abstract class Failure {
  final String message;
  const Failure(this.message);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Storage permission not granted']);
}

class ScanFailure extends Failure {
  const ScanFailure(super.message);
}

class DeleteFailure extends Failure {
  const DeleteFailure(super.message);
}
class PlatformFailure extends Failure {
  const PlatformFailure(super.message);
}
