import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:task_app/views/project/add_new_project.dart';
import 'package:task_app/widget/common/nav_bar.dart';
import 'package:task_app/widget/common/custom_bottom_navigation_bar.dart';

import 'package:task_app/provider/service_provider.dart';
import 'package:task_app/widget/searchBtn.dart';
import 'package:task_app/widget/task%20(1)/task/add_new_task.dart';
import 'package:task_app/widget/task%20(1)/task/add_task_button.dart';
import 'package:task_app/widget/task%20(1)/task/card_todo_list_widget.dart';

// Import the search page

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  // List to hold the tasks
  List<String> tasks = [];

  // Variable to store the image path
  String projectImagePath = 'assets/images/project.jpeg';
  var h1 = 120.0;
  var w1 = 120.0;
  Color? c1 = Colors.grey[800];

  @override
  Widget build(BuildContext context) {
    // Fetch todo data using Riverpod
    final todoData = ref.watch(fetchStreamProvider);

    // GlobalKey for Scaffold
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: NavBar(), // Drawer navigation
      appBar: AppBar(
        backgroundColor: const Color(0xff8145E5),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/raster/avatar-8.png'),
              radius: 25,
            ),
            SizedBox(width: 10),
            Text(
              'Hi, Rose !', // Greeting
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.list),
          onPressed: () => scaffoldKey.currentState!.openDrawer(), // Open drawer on button press
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>SearchPage(), // Navigate to your search page
              ));
            },
            icon: const Icon(
              Icons.search,
              size: 40,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Gap(20), // Widget for spacing
              // Container for "My Projects" section///////////////////////////////////////////
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color:c1, // Set background color to gray
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Projects', // Section title
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Current Projects', // Subtitle
                            style: TextStyle(color: Colors.grey[200]),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: h1, // Set the desired height for the image container
                          width: w1, // Set the desired width for the image container
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(projectImagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          final newImagePath = 'assets/images/tasko.jpg' ;
                          final newn = await showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            context: context,
                            builder: (context) => const AddbtnSheett(),
                          );

                          if (newImagePath != null) {
                            setState(() {
                              projectImagePath = newImagePath;
                              h1=600.0;
                              w1=600.0;
                              c1 =Colors.grey[1000];
                            });
                          }
                        },
                        child: const Text('+ New Project'), // Button text
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20), // Widget for spacing
              // ListView for displaying todo items
              
              const SizedBox(height: 20), // Widget for spacing
              // Container for "My Tasks" section
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[800], // Set background color to gray
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Tasks', // Section title
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Today\'s Tasks', // Subtitle
                            style: TextStyle(color: Colors.grey[200]),
                          ),
                          const SizedBox(height: 10),
                          
                          SizedBox(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: tasks.length,
                              itemBuilder: (context, index) =>
                                  CardTodoListWidget(getIndex: index),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 120, // Set the desired height for the image container
                          width: 120, // Set the desired width for the image container
                          child: SizedBox(
                            child: Container(
                              height: 300, // Set the height to 300
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/tskkkkkkk3.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          context: context,
                          builder: (context) => const AddNewTaskSheet(),
                        ),
                        child: const Text('+ New Task'), // Button text
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20), // Widget for spacing
              // Add your projects here
            ],
          ),
        ),
      ),
      
       floatingActionButton: const AddTaskButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
       // Custom bottom navigation bar
    );
  }
  
}
