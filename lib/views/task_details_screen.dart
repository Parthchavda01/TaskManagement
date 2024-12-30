import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagementapp/utils/dimensions.dart';
import 'package:taskmanagementapp/utils/string_helper.dart';
import 'package:taskmanagementapp/utils/text_styles.dart';
import 'package:taskmanagementapp/utils/alert_dilog.dart';
import '../view_models/task_view_model.dart';

class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(selectedTaskProvider);
    if (task == null) {
      return const Center(child: Text('No task selected.'));
    }

    return Padding(
      padding: EdgeInsets.only(
          top: 20,
          left: Dimensions.paddingLeftRight10,
          right: Dimensions.paddingLeftRight10),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: Dimensions.paddingLeftRight10,
              right: Dimensions.paddingLeftRight10),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:
                  BorderRadius.circular(Dimensions.commonBorderRadius)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: montserratTextStyle(context),
                  ),
                  IconButton(
                    color: Colors.black,
                    icon: const Icon(Icons.edit),
                    onPressed: () => showTaskDialog(context, ref,
                        isEditing: true, task: task),
                  ),
                ],
              ),
              Container(
                constraints: BoxConstraints(minHeight: 50),
                // height: 50,
                // color: Colors.amber,
                child: SingleChildScrollView(
                  child: Text(
                    task.description,
                    style: openSansTextStyle(context),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Created On:   ',
                        style: openSansTextStyle(context,
                            fontsize: Dimensions.commonFontSize),
                      ),
                      Text(
                        formatDateString(task.dateCreated),
                        style: openSansTextStyle(context,
                            fontsize: Dimensions.commonFontSize),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Status:            ',
                        style: openSansTextStyle(context,
                            fontsize: Dimensions.commonFontSize),
                      ),
                      Text(
                        task.isCompleted ? 'Completed' : 'Pending',
                        style: openSansTextStyle(context,
                            color: task.isCompleted
                                ? Colors.lightGreen
                                : Colors.redAccent,
                            fontsize: Dimensions.commonFontSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
