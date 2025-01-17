import 'dart:developer';

import '../../core/notifier/default_change_notifier.dart';
import '../../services/task/task_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TaskService _taskService;
  DateTime? _selectedDate;

  TaskCreateController({required TaskService taskService})
      : _taskService = taskService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

void saveTask(String title, String description) async {
    try {
      showLoadingAndReset();
      notifyListeners();

      if (_selectedDate != null) {
        await _taskService.saveTask(title, description, _selectedDate!);
        success();
      } else {
        setError('Selecione uma data.');
      }
    } catch (e, s) {
      log('Erro: $e, stackTrace: $s');
      setError('Erro ao salvar tarefa.');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
