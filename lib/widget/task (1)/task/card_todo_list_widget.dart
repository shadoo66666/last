import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:task_app/provider/service_provider.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({super.key, required this.getIndex});

  final int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
      data: (todoData) {
        Color categoryColor = Colors.grey.shade100;
        final getCategory = todoData[getIndex].category;
        switch (getCategory) {
          case 'Learning':
            categoryColor = Colors.green;
            break;
          case 'Working':
            categoryColor = Colors.blue.shade700;
            break;
          case 'General':
            categoryColor = Colors.amber.shade700;
            break;
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          icon: const Icon(CupertinoIcons.delete, color: Colors.red,),
                          onPressed: () => ref
                              .read(serviceProvider)
                              .deleteTask(todoData[getIndex].docID),
                        ),
                        title: Text(
  todoData[getIndex].titleTask,
  maxLines: 1,
  style: TextStyle(
    decoration: todoData[getIndex].isDone
        ? TextDecoration.lineThrough
        : null,
    decorationColor: Colors.black, // Set the color of the line here
    color: Colors.black,
    fontSize: 18,
  ),
),
subtitle: Text(
  todoData[getIndex].description,
  maxLines: 1,
  style: TextStyle(
    decoration: todoData[getIndex].isDone
        ? TextDecoration.lineThrough
        : null,
    decorationColor: Colors.black, // Set the color of the line here
    color: Colors.black,
  ),
),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: Colors.blue.shade400,
                            shape: const CircleBorder(),
                            value: todoData[getIndex].isDone,
                            onChanged: (value) => ref
                                .read(serviceProvider)
                                .updateTask(todoData[getIndex].docID, value),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Column(
                          children: [
                            Divider(
                              thickness: 1.5,
                              color: Colors.grey.shade400,
                            ),
                            Row(
                              children: [
                                Text(todoData[getIndex].dateTask, style: TextStyle(color: Colors.black)),
                                const Gap(12),
                                Text(todoData[getIndex].timeTask, style: TextStyle(color: Colors.black))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(stackTrace.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
