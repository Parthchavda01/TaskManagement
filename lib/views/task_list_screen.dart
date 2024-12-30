import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagementapp/services/preferences_service.dart';
import 'package:taskmanagementapp/utils/dimensions.dart';
import 'package:taskmanagementapp/utils/string_helper.dart';
import 'package:taskmanagementapp/views/task_details_screen.dart';
import 'package:taskmanagementapp/utils/alert_dilog.dart';
import 'package:taskmanagementapp/utils/text_styles.dart';
import '../models/task.dart';
import '../view_models/task_view_model.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var selectedTask = ref.watch(selectedTaskProvider);
    final tasks = ref.watch(taskProvider);
    final isTablet = MediaQuery.of(context).size.width > 600;
    final themeMode = ref.watch(themeProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    // Filter tasks based on the search query
    final filteredTasks = tasks
        .where((task) =>
            task.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        scrolledUnderElevation: 0,
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(
              themeMode.isDarkTheme == true
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
            ),
            onPressed: () {
              ref
                  .read(themeProvider.notifier)
                  .toggleTheme(); // Toggle the theme
            },
          ),
        ],
      ),
      body: isTablet
          ? Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _TaskListView(
                    tasks: filteredTasks,
                    isTablet: true,
                    ref: ref,
                    searchController: _searchController,
                    onSearchChanged: (query) {
                      ref.read(searchQueryProvider.notifier).state = query;
                    },
                    onTaskSelected: (task) {
                      ref.read(selectedTaskProvider.notifier).state = task;
                    },
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  flex: 3,
                  child: selectedTask != null
                      ? const TaskDetailScreen()
                      : const Center(
                          child: Text('Select a task to view details'),
                        ),
                ),
              ],
            )
          : _TaskListView(
              tasks: filteredTasks,
              isTablet: false,
              ref: ref,
              searchController: _searchController,
              onSearchChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
              },
              onTaskSelected: (task) {
                showTaskDialog(context, ref, isEditing: true, task: task);
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.sort,
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor),
              onPressed: () {
                _showSortOrderMenu(context);
              },
            ),
            FloatingActionButton(
              onPressed: () => showAddDialog(context, ref),
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showAddDialog(BuildContext context, WidgetRef ref) {
    showTaskDialog(context, ref, isEditing: false);
  }

  void _showSortOrderMenu(BuildContext context) {
    final currentSortOrder = ref.read(themeProvider).sortOrder;

    showMenu<String>(
      color: Colors.white,
      context: context,
      position:
          RelativeRect.fromLTRB(0, MediaQuery.of(context).size.height, 0, 0),
      items: [
        PopupMenuItem<String>(
          value: 'date',
          child: Text(
              currentSortOrder == 'date' ? 'Sort by Date ✓' : 'Sort by Date'),
        ),
        PopupMenuItem<String>(
          value: 'isCompleted',
          child: Text(currentSortOrder == 'isCompleted'
              ? 'Sort by Completion ✓'
              : 'Sort by Completion'),
        ),
      ],
    ).then((selectedSortOrder) {
      if (selectedSortOrder != null && selectedSortOrder != currentSortOrder) {
        ref.read(themeProvider.notifier).updateSortOrder(selectedSortOrder);
      }
    });
  }
}

class _TaskListView extends StatelessWidget {
  final List<Task> tasks;
  final bool isTablet;
  final WidgetRef ref;
  final Function(Task) onTaskSelected;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const _TaskListView({
    required this.tasks,
    required this.isTablet,
    required this.ref,
    required this.onTaskSelected,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingLeftRight10),
      child: Column(
        children: [
          TextField(
            cursorColor: const Color.fromARGB(255, 164, 99, 141),
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 164, 99, 141)),
                  borderRadius:
                      BorderRadius.circular(Dimensions.commonBorderRadius)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 164, 99, 141)),
                  borderRadius:
                      BorderRadius.circular(Dimensions.commonBorderRadius)),
              hintText: 'Search tasks...',
              hintStyle:
                  openSansTextStyle(context, color: Colors.grey.shade500),
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search, color: Colors.grey.shade500),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(
                    child: Text(
                    'No tasks available',
                    style: openSansTextStyle(context,
                        color: Theme.of(context)
                            .floatingActionButtonTheme
                            .backgroundColor),
                  ))
                : ListView.separated(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        minTileHeight: isTablet ? 70 : 150,
                        title: Text(
                          task.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: montserratTextStyle(context),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 80,
                              child: Text(
                                task.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: openSansTextStyle(context),
                              ),
                            ),
                            if (!isTablet)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Created On:   ',
                                        style: openSansTextStyle(context,
                                            fontsize:
                                                Dimensions.commonFontSize),
                                      ),
                                      Text(
                                        formatDateString(task.dateCreated),
                                        style: openSansTextStyle(context,
                                            fontsize:
                                                Dimensions.commonFontSize),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Status:            ',
                                        style: openSansTextStyle(context,
                                            fontsize:
                                                Dimensions.commonFontSize),
                                      ),
                                      Text(
                                        task.isCompleted
                                            ? 'Completed'
                                            : 'Pending',
                                        style: openSansTextStyle(context,
                                            color: task.isCompleted
                                                ? Colors.lightGreen
                                                : Colors.redAccent,
                                            fontsize:
                                                Dimensions.commonFontSize),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ],
                        ),
                        trailing: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            ref
                                .read(taskProvider.notifier)
                                .toggleCompletion(task, ref);
                          },
                        ),
                        onTap: () => onTaskSelected(task),
                        onLongPress: () => ref
                            .read(taskProvider.notifier)
                            .deleteTask(task.id!),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
