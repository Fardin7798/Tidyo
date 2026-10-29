import 'package:flutter/foundation.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/Dashboard/Domain/Entities/StoragePartitionEntity.dart';
import 'package:tidyo/Features/Dashboard/Domain/UseCases/GetStoragePartitionUseCase.dart';

class DashboardProvider extends ChangeNotifier {
  final GetStoragePartitionUseCase getStoragePartitionUseCase;

  DashboardProvider({required this.getStoragePartitionUseCase});

  StoragePartitionEntity _partition = const StoragePartitionEntity(
    totalBytes: 227 * 1024 * 1024 * 1024,
    freeBytes: 148 * 1024 * 1024 * 1024,
    usedBytes: 79 * 1024 * 1024 * 1024,
  );

  bool _isLoading = false;
  String? _errorMessage;

  StoragePartitionEntity get partition => _partition;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadStorageMetrics() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getStoragePartitionUseCase(const NoParams());
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (data) {
        _partition = data;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
