import 'package:flutter/material.dart';
import 'data/index.dart';
import 'quzheng/index.dart';
import 'user/personal.dart';

class HomePage extends StatefulWidget {
  num pageNum;
  HomePage({this.pageNum});
  @override
  State<StatefulWidget> createState() {
    return _HomePageStata();
  }
}

class _HomePageStata extends State<HomePage> {
  List _pages = [DataPage(), QuzhengPage(), PersonalPage()];
  num _pageNum;
  void _onItemTapped(int index) {
    setState(() {
      _pageNum = index;
    });
  }

  @override
  void initState() {
    if (widget.pageNum == null) {
      _pageNum = 1;
    } else {
      _pageNum = widget.pageNum;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text('公告'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            title: Text('任务'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            title: Text('事件'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我'),
          ),
        ],
        currentIndex: _pageNum,
        onTap: _onItemTapped,
      ),
      body: _pages[_pageNum],
    );
  }
}
