import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:task_app/widget/common/custom_bottom_navigation_bar.dart';
import 'package:task_app/provider/service_provider.dart';
import 'package:task_app/widget/task%20(1)/task/add_task_button.dart';
import 'package:task_app/widget/task%20(1)/task/card_todo_list_widget.dart';

class AllTaskScreen extends ConsumerWidget {
  const AllTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff8145E5),
        title: Text('All Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Gap(13),
            ElevatedButton(
              onPressed: () {
                // Add functionality for filter button
              },
              child: const Row(
                children: [
                  FaIcon(FontAwesomeIcons.filter),
                  SizedBox(width: 8), // Added space between icon and text
                  Text('Filters'),
                ],
              ),
            ),
            Gap(15),
            Expanded(
              child: ListView.builder(
                itemCount: todoData.value?.length ?? 0,
                itemBuilder: (context, index) =>
                    CardTodoListWidget(getIndex: index),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const AddTaskButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
