import 'package:flutter/material.dart';
import 'package:task_app/widget/task%20(1)/task/add_new_task.dart';


class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16)), // Rounded RectangleB
                context: context,
                builder: (context) => const AddNewTaskSheet(),
              ), // Container,
      shape:  const CircleBorder(),
      child: const Text('+ Task')
    );
  }
}
