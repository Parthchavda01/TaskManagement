import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagementapp/services/preferences_service.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class TaskViewModel extends StateNotifier<List<Task>> {
  final DatabaseService _dbService;
  final Ref ref;

  TaskViewModel(this._dbService, this.ref) : super([]) {
    _loadTasks();
  }

 Future<void> _loadTasks() async {
    final tasks = await _dbService.getTasks();
    final sortOrder = ref.watch(themeProvider).sortOrder;
    
    // Sort tasks based on the selected sort order
    if (sortOrder == 'date') {
      tasks.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    } else if (sortOrder == 'isCompleted') {
      tasks.sort((a, b) => a.isCompleted == b.isCompleted
          ? b.dateCreated.compareTo(a.dateCreated)
          : a.isCompleted ? 1 : -1);
    }

    state = tasks;
  }
  

  Future<void> addTask(Task task) async {
    await _dbService.addTask(task);
    _loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _dbService.updateTask(task);
    _loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _dbService.deleteTask(id);
    _loadTasks();
  }

  // Future<void> toggleCompletion(Task task) async {
  //   final updatedTask = Task(
  //     id: task.id,
  //     title: task.title,
  //     description: task.description,
  //     isCompleted: !task.isCompleted,
  //     dateCreated: task.dateCreated
  //   );
  //   await updateTask(updatedTask);
  // }
  Future<void> toggleCompletion(Task task, WidgetRef ref) async {
  final updatedTask = Task(
    id: task.id,
    title: task.title,
    description: task.description,
    isCompleted: !task.isCompleted,
    dateCreated: task.dateCreated,
  );

  await updateTask(updatedTask);

  // Ensure selectedTaskProvider is updated if the toggled task is the selected one
  final selectedTask = ref.read(selectedTaskProvider);
  if (selectedTask?.id == task.id) {
    ref.read(selectedTaskProvider.notifier).state = updatedTask;
  }
}
}
final searchQueryProvider = StateProvider<String>((ref) => '');

final selectedTaskProvider = StateProvider<Task?>((ref) => null);
final taskProvider = StateNotifierProvider<TaskViewModel, List<Task>>((ref) {
  return TaskViewModel(DatabaseService.instance,ref);
});
