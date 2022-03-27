import 'package:consultancy_app/Screens/adminScreens/allUsers.dart';
import 'package:consultancy_app/Screens/home_page.dart';
import 'package:flutter/material.dart';

import 'adminScreens/chatLists.dart';


class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  // List<Map<String, Object>> _pages;
  ScrollController? _scrollController;
  var top = 0.0;

  @override
  void initState() {
    pages = [
      const HomePage(),
      UserNSearch(),
      ChatLists(),
    ];
    //
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      setState(() {});
    });
    // getData();
  }


  int _selectedPageIndex = 0;
  late List pages;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pages[_selectedPageIndex], //_pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.white,
              selectedItemColor: const Color(0xff805130),
              currentIndex: _selectedPageIndex,
              // selectedLabelStyle: TextStyle(fontSize: 16),
              items:const [
                 BottomNavigationBarItem(
                    icon: Icon(Icons.room_service), label: 'For You'),
               
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.people,
                    ),
                    label: 'All Users'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat_bubble,
                    ),
                    label: 'Admin Chats'),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
