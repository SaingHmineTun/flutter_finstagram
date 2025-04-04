import 'package:finstagram/pages/home/newsfeed_widget.dart';
import 'package:finstagram/pages/home/profile_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> widgets = [NewsfeedWidget(), ProfileWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _navBar(),
      body: _home(),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: ColorScheme.of(context).primary,
      title: Text(
        "Finstagram",
        style: TextStyle(color: ColorScheme.of(context).onPrimary),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.logout, color: ColorScheme.of(context).onPrimary),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add_a_photo,
            color: ColorScheme.of(context).onPrimary,
          ),
        ),
      ],
    );
  }

  _navBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: ColorScheme.of(context).error,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.feed), label: "Feeds"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }

  _home() {
    return widgets[_currentIndex];
  }
}
