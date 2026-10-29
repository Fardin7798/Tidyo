import 'package:flutter/foundation.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/DeepClean/Domain/Entities/MediaMetricsEntity.dart';
import 'package:tidyo/Features/DeepClean/Domain/UseCases/ScanMediaMetricsUseCase.dart';

class DeepCleanProvider extends ChangeNotifier {
  final ScanMediaMetricsUseCase scanMediaMetricsUseCase;

  DeepCleanProvider({required this.scanMediaMetricsUseCase});

  MediaMetricsEntity _metrics = const MediaMetricsEntity(
    whatsappBytes: 1200000000,
    telegramBytes: 53000000,
    browserBytes: 420000000,
  );

  bool _isLoading = false;
  String? _errorMessage;

  MediaMetricsEntity get metrics => _metrics;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadMetrics() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await scanMediaMetricsUseCase(const NoParams());
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (data) {
        _metrics = data;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
