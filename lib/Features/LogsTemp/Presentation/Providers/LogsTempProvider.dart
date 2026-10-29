import 'package:flutter/foundation.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/LogsTemp/Domain/Entities/LogTempItemEntity.dart';
import 'package:tidyo/Features/LogsTemp/Domain/UseCases/GetLogsTempListUseCase.dart';
import 'package:tidyo/Features/LogsTemp/Domain/UseCases/DeleteLogsTempUseCase.dart';

class LogsTempProvider extends ChangeNotifier {
  final GetLogsTempListUseCase getLogsTempListUseCase;
  final DeleteLogsTempUseCase deleteLogsTempUseCase;

  LogsTempProvider({
    required this.getLogsTempListUseCase,
    required this.deleteLogsTempUseCase,
  });

  List<LogTempItemEntity> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<LogTempItemEntity> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadLogsTemp() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getLogsTempListUseCase(const NoParams());
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (list) {
        _items = list;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<bool> deleteItem(String path) async {
    final result = await deleteLogsTempUseCase(DeleteLogsTempParams(path));
    final success = result.fold((failure) => false, (s) => s);
    if (success) {
      _items.removeWhere((item) => item.dir == path || item.name == path);
      notifyListeners();
    }
    return success;
  }
}
