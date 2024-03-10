
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app/model/todo_model.dart';
import 'package:task_app/provider/date_time_provider.dart';
import 'package:task_app/provider/radio_provider.dart';
import 'package:task_app/provider/service_provider.dart';

class CreateTaskButton extends StatelessWidget {
  const CreateTaskButton({
    super.key,
    required this.ref,
    required this.titleController,
    required this.descriptionController,
  });

  final WidgetRef ref;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff8145E5),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () {
          final getRadioValue = ref.read(radioProvider);
          String category = '';
    
          switch (getRadioValue) {
            case 1:
              category = 'Learning';
              break;
            case 2:
              category = 'Working';
              break;
            case 3:
              category = 'General';
              break;
          }
          ref.read(serviceProvider).addNewTask(TodoModel(
              titleTask: titleController.text,
              description: descriptionController.text,
              category: category,
              dateTask: ref.read(dateProvider),
              timeTask: ref.read(timeProvider),
              isDone: false));
    
          titleController.clear();
          descriptionController.clear();
          ref.read(radioProvider.notifier).update((state) => 0);
          Navigator.pop(context);
        },
        child: const Text('Create', style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
