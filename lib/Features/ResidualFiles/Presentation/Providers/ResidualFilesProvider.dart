import 'package:flutter/foundation.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/Entities/ResidualFolderEntity.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/UseCases/GetResidualFoldersUseCase.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/UseCases/DeleteResidualFolderUseCase.dart';

class ResidualFilesProvider extends ChangeNotifier {
  final GetResidualFoldersUseCase getResidualFoldersUseCase;
  final DeleteResidualFolderUseCase deleteResidualFolderUseCase;

  ResidualFilesProvider({
    required this.getResidualFoldersUseCase,
    required this.deleteResidualFolderUseCase,
  });

  List<ResidualFolderEntity> _folders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ResidualFolderEntity> get folders => _folders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadResidualFolders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getResidualFoldersUseCase(const NoParams());
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (list) {
        _folders = list;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<bool> deleteFolder(String path) async {
    final result = await deleteResidualFolderUseCase(DeleteResidualFolderParams(path));
    final success = result.fold((failure) => false, (s) => s);
    if (success) {
      _folders.removeWhere((f) => f.path == path);
      notifyListeners();
    }
    return success;
  }
}
