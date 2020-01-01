import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/screens/activity_screen.dart';
import 'package:mobile_project/screens/create_post_screen.dart';
import 'package:mobile_project/screens/feed_screen.dart';
import 'package:mobile_project/screens/profile_screen.dart';
import 'package:mobile_project/screens/search_screen.dart';
import 'package:mobile_project/services/auth_service.dart';

class HomeScreen extends StatefulWidget {

  final String userId;

  HomeScreen({this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.power_settings_new),
              onPressed: () => AuthService.logout(context), 
            ),
        ],
        backgroundColor: Colors.black87,
        title: Center(
          child: Text(
            "Tubes Mobile",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Billabong',
              fontSize: 35.0,
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedScreen(),
          SearchScreen(),
          CreatePostScreen(),
          ActivityScreen(),
          ProfileScreen(userId: widget.userId)
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        activeColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
            Icons.home,
            size: 32.0,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.search,
            size: 32.0,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.photo_camera,
            size: 32.0,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.notifications,
            size: 32.0,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.account_circle,
            size: 32.0,
          ))
        ],
      ),
    );
  }
}
