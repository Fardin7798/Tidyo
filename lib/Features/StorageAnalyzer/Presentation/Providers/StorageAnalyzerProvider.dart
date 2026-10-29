import 'package:flutter/foundation.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/Entities/BigFileEntity.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/UseCases/GetBigFilesUseCase.dart';

class StorageAnalyzerProvider extends ChangeNotifier {
  final GetBigFilesUseCase getBigFilesUseCase;

  StorageAnalyzerProvider({required this.getBigFilesUseCase});

  List<BigFileEntity> _bigFiles = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _selectedThresholdIndex = 1;

  static const List<int> thresholds = [
    25 * 1024 * 1024,
    50 * 1024 * 1024,
    100 * 1024 * 1024,
  ];

  List<BigFileEntity> get bigFiles => _bigFiles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedThresholdIndex => _selectedThresholdIndex;
  int get currentThreshold => thresholds[_selectedThresholdIndex];

  Future<void> loadBigFiles({int? thresholdIndex}) async {
    if (thresholdIndex != null) {
      _selectedThresholdIndex = thresholdIndex;
    }
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getBigFilesUseCase(
      GetBigFilesParams(minBytes: currentThreshold),
    );

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (files) {
        _bigFiles = files;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
