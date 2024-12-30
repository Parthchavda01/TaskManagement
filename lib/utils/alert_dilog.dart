import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagementapp/models/task.dart';
import 'package:taskmanagementapp/utils/dimensions.dart';
import 'package:taskmanagementapp/utils/text_field.dart';
import 'package:taskmanagementapp/utils/text_styles.dart';
import 'package:taskmanagementapp/view_models/task_view_model.dart';

void showTaskDialog(BuildContext context, WidgetRef ref,
    {bool isEditing = false, Task? task}) {
  final titleController = TextEditingController(text: task?.title ?? '');
  final descriptionController =
      TextEditingController(text: task?.description ?? '');

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceBetween,
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonTextField(context, titleController, 'Title'),
            commonTextField(context, descriptionController, 'Description')
            
           
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: montserratTextStyle(context,
                  fontsize: Dimensions.commonFontSize * 1.5),
            ),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newTask = Task(
                    id: isEditing ? task?.id : null,
                    title: titleController.text,
                    description: descriptionController.text,
                    dateCreated: DateTime.now());
                if (isEditing) {
                  ref.read(taskProvider.notifier).updateTask(newTask);
                  ref.read(selectedTaskProvider.notifier).state = newTask;
                } else {
                  ref.read(taskProvider.notifier).addTask(newTask);
                }
                Navigator.of(context).pop();
              }
            },
            child: Text(
              isEditing ? 'Save' : 'Add',
              style: montserratTextStyle(context,
                  fontsize: Dimensions.commonFontSize * 1.5),
            ),
          ),
        ],
      );
    },
  );
}
