import 'package:flutter/foundation.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/AppCache/Domain/Entities/AppCacheEntity.dart';
import 'package:tidyo/Features/AppCache/Domain/UseCases/GetAppCacheListUseCase.dart';
import 'package:tidyo/Features/AppCache/Domain/UseCases/LaunchAppDetailsUseCase.dart';

class AppCacheProvider extends ChangeNotifier {
  final GetAppCacheListUseCase getAppCacheListUseCase;
  final LaunchAppDetailsUseCase launchAppDetailsUseCase;

  AppCacheProvider({
    required this.getAppCacheListUseCase,
    required this.launchAppDetailsUseCase,
  });

  List<AppCacheEntity> _apps = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<AppCacheEntity> get apps => _apps;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAppCache() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getAppCacheListUseCase(const NoParams());
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (list) {
        _apps = list;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<bool> openAppDetails(String packageName) async {
    final result = await launchAppDetailsUseCase(LaunchAppDetailsParams(packageName));
    return result.fold((failure) => false, (success) => success);
  }
}
