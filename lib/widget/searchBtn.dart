import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  late Stream<QuerySnapshot> _tasksStream;
  late Stream<QuerySnapshot> _projectsStream;
  late Stream<QuerySnapshot> _peopleStream;
  late Stream<QuerySnapshot> _teamsStream;
  // late Stream<QuerySnapshot> _tagsStream;
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _tasksStream = FirebaseFirestore.instance.collection('tasks').snapshots();
    _projectsStream =
        FirebaseFirestore.instance.collection('projects').snapshots();
    _peopleStream = FirebaseFirestore.instance.collection('people').snapshots();
    _teamsStream = FirebaseFirestore.instance.collection('teams').snapshots();
    // _tagsStream = FirebaseFirestore.instance.collection('tags').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Task Management App'),
          ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Container(
              width: double
                  .infinity, // Ensure the inner container expands horizontally
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Add border
                borderRadius:
                    BorderRadius.circular(8.0), // Optional: Add border radius
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search My workspace',
                          border: InputBorder.none, // Remove TextField border
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _showResults = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          _showResults
              ? Expanded(
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                _buildFilterChip('Tasks'),
                                const SizedBox(width: 8.0),
                                _buildFilterChip('Projects'),
                                const SizedBox(width: 8.0),
                                _buildFilterChip('People'),
                                const SizedBox(width: 8.0),
                                _buildFilterChip('Teams'),
                                // SizedBox(width: 8.0),
                                // _buildFilterChip('Tags'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      StreamBuilder(
                        stream: _tasksStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              !snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tasks',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var taskData = snapshot.data!.docs[index]
                                      .data() as Map<String, dynamic>;
                                  return ListTile(
                                    title: Text(taskData['title']),
                                    subtitle: Text(taskData['description']),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return FilterChip(
      label: Text(label),
      onSelected: (selected) {
        // Handle filter selection
      },
    );
  }
}