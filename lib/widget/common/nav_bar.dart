import 'package:flutter/material.dart';
import 'package:task_app/views/dashborad/dashboard.dart';
import 'package:task_app/views/project/projects_view.dart';
import 'package:task_app/views/task/all_task_screen%20(1).dart';

import 'package:task_app/views/task_recommend/RecommendPage.dart';
import 'package:task_app/widget/Calendar.dart';
import 'package:task_app/widget/common/logout.dart';
import 'package:task_app/widget/porfile_folder/profile.dart';

import '../../views/settings_page.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Drawer(
        backgroundColor: Colors.grey.shade900,
        
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            // name: 'Your Name',
                            // email: 'your_email@example.com',
                            // profileImage:
                            //     'https://example.com/your_profile_image.jpg',
                          )),
                );
              },
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  'Rose',
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
                accountEmail: Text(
                  'Rose@gmail.com',
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.person,size: 50,), // Change to person icon
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.checklist_rtl, color: Colors.white), // Set icon color to white
              title: Text('Your Tasks', style: TextStyle(color: Colors.white)), // Set text color to white
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllTaskScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.ballot_outlined, color: Colors.white), // Set icon color to white
              title: Text('Your Projects', style: TextStyle(color: Colors.white)), // Set text color to white
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProjectsView()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.date_range_rounded, color: Colors.white), // Set icon color to white
              title: Text('Calendar', style: TextStyle(color: Colors.white)), // Set text color to white
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart, color: Colors.white), // Set icon color to white
              title: Text('Dashboard', style: TextStyle(color: Colors.white)), // Set text color to white
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TheDashboard()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.recommend_outlined, color: Colors.white), // Set icon color to white
              title: Row(
                children: [
                  Text('Task Recommend', style: TextStyle(color: Colors.white)), // Set text color to white
                  SizedBox(width: 10),
                  Container(
                    width: 1,
                    color: Colors.grey,
                    height: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'soon',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskRecommendPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white), // Set icon color to white
              title: Text('Settings', style: TextStyle(color: Colors.white)), // Set text color to white
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SettingsPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Log Out', style: TextStyle(color: Colors.white)), // Set text color to white
              leading: Icon(Icons.exit_to_app, color: Colors.white), // Set icon color to white
              onTap: () {
                LogoutPage.showLogoutDialog(
                    context); // Call the showLogoutDialog function
              },
            ),
          ],
        ),
      ),
    );
  }
}
