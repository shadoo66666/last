import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:task_app/constants/app_style.dart';
import 'package:task_app/widget/task%20(1)/task/category_selection.dart';
import 'package:task_app/widget/task%20(1)/task/create_task_button.dart';
import 'package:task_app/widget/task%20(1)/task/date_time_row.dart';
import 'package:task_app/widget/task%20(1)/task/priority_selection_button.dart';
import 'package:task_app/widget/task%20(1)/task/progress_selector.dart';
import 'package:task_app/widget/task%20(1)/task/recurring_task.dart';
import 'package:task_app/widget/task%20(1)/task/subtask_section.dart';
import 'package:task_app/widget/task%20(1)/task/textfield_widget.dart';


class AddNewTaskSheet extends ConsumerStatefulWidget {
  const AddNewTaskSheet({Key? key}) : super(key: key);

  @override
  AddNewTaskModelState createState() => AddNewTaskModelState();
}

class AddNewTaskModelState extends ConsumerState<AddNewTaskSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedPriority = 'No Priority';
  String selectedProgress = 'TO DO';
  List<TextEditingController> subtaskControllers = [];
  late TaskProgressSelector taskProgressSelector;
  late String selectedRecurring = 'No Recurring';

  @override
  void initState() {
    super.initState();
    taskProgressSelector = TaskProgressSelector(
      defaultProgress: selectedProgress,
      onProgressChanged: (progress) {
        setState(() {
          selectedProgress = progress;
          taskProgressSelector.updateProgressIndicator(context);
        });
      },
    );
    taskProgressSelector.updateProgressIndicator(context);
  }

  void _updateRecurring(String? value) {
    if (value != null) {
      setState(() {
        selectedRecurring = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: const Color(0xff8145E5),
        title: const Text(
          'New Task Todo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: const BoxDecoration(
            color: Color(0xff1C1C1C),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(thickness: 1.2, color: Colors.grey),
              const Gap(12),
              const Text(
                'Title Task',
                style: AppStyle.headingOne,
              ),
              const Gap(6),
              TextFieldWidget(
                hintText: 'Add Task Name',
                txtController: titleController,
              ),
              const Gap(12),
              const Text('Description', style: AppStyle.headingOne),
              const Gap(6),
              TextFieldWidget(
                hintText: 'Add Descriptions',
                txtController: descriptionController,
              ),
              const Gap(12),
              taskProgressSelector.progressIndicator,
              const Gap(12),
              CategorySelection(ref: ref),
              DateTimeRow(ref: ref),
              const Gap(12),
              PrioritySelectionButton(
                selectedPriority: selectedPriority,
                onPrioritySelected: (priority) {
                  setState(() {
                    selectedPriority = priority;
                  });
                },
              ),
              const Gap(12),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TaskOptionsDialog(
                        selectedRecurring: selectedRecurring,
                        skipWeekends: false,
                        daysAfter: 0,
                        onRecurringChanged: _updateRecurring,
                        onSkipWeekendsChanged: (value) {
                          // Handle skip weekends option change
                        },
                        onDaysAfterChanged: (value) {
                          // Handle days after option change
                        },
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.repeat, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      selectedRecurring,
                      style:AppStyle.headingOne,
                    ),
                  ],
                ),
              ),
              const Gap(12),
              SubtaskSection(subtaskControllers: subtaskControllers),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CreateTaskButton(
            ref: ref,
            titleController: titleController,
            descriptionController: descriptionController,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
