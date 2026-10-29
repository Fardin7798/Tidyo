import 'package:flutter/foundation.dart';
import 'package:tidyo/Features/JunkScanner/Domain/Entities/JunkItemEntity.dart';
import 'package:tidyo/Features/JunkScanner/Domain/UseCases/ScanJunkUseCase.dart';
import 'package:tidyo/Features/JunkScanner/Domain/UseCases/DeleteJunkUseCase.dart';

class JunkScannerProvider extends ChangeNotifier {
  final ScanJunkUseCase scanJunkUseCase;
  final DeleteJunkUseCase deleteJunkUseCase;

  JunkScannerProvider({
    required this.scanJunkUseCase,
    required this.deleteJunkUseCase,
  });

  bool _isScanning = false;
  bool _showResults = false;
  double _scanProgress = 0.0;
  int _scannedFiles = 0;
  String _currentPath = '/storage/emulated/0';
  int _foundBytes = 0;
  List<JunkItemEntity> _scannedJunk = [];
  String? _errorMessage;

  bool get isScanning => _isScanning;
  bool get showResults => _showResults;
  double get scanProgress => _scanProgress;
  int get scannedFiles => _scannedFiles;
  String get currentPath => _currentPath;
  int get foundBytes => _foundBytes;
  List<JunkItemEntity> get scannedJunk => _scannedJunk;
  String? get errorMessage => _errorMessage;

  void dismissResults() {
    _showResults = false;
    notifyListeners();
  }

  void stopScan() {
    scanJunkUseCase.stop();
    _isScanning = false;
    notifyListeners();
  }

  Future<void> startScan() async {
    _isScanning = true;
    _showResults = false;
    _scanProgress = 0.05;
    _scannedFiles = 0;
    _foundBytes = 0;
    _currentPath = '/storage/emulated/0';
    _errorMessage = null;
    notifyListeners();

    final result = await scanJunkUseCase(
      ScanJunkParams(
        onProgress: (path, count, bytes) {
          _currentPath = path;
          _scannedFiles = count;
          _foundBytes = bytes;
          _scanProgress = (_scannedFiles / 3000.0).clamp(0.05, 0.95);
          notifyListeners();
        },
      ),
    );

    result.fold(
      (failure) {
        _isScanning = false;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (items) {
        _isScanning = false;
        _scanProgress = 1.0;
        _scannedJunk = items;
        _showResults = true;
        notifyListeners();
      },
    );
  }

  Future<int> deleteSelected(List<JunkItemEntity> items) async {
    final result = await deleteJunkUseCase(items);
    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
        return 0;
      },
      (deletedBytes) {
        _scannedJunk = _scannedJunk.where((item) => !items.contains(item)).toList();
        notifyListeners();
        return deletedBytes;
      },
    );
  }
}
