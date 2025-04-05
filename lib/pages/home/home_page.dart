import 'package:finstagram/pages/home/newsfeed_widget.dart';
import 'package:finstagram/pages/home/profile_widget.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:finstagram/widgets/mao_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> widgets = [NewsfeedWidget(), ProfileWidget()];
  late FirebaseService _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

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
          icon: Icon(
            Icons.add_a_photo,
            color: ColorScheme.of(context).onPrimary,
          ),
        ),

        IconButton(
          onPressed: _showLogoutDialog,
          icon: Icon(Icons.logout, color: ColorScheme.of(context).onPrimary),
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

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Warning!"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            MaoButton(
              onClick: () {
                Navigator.pop(context);
              },
              text: "No",
              bgColor: ColorScheme.of(context).error,
              textColor: ColorScheme.of(context).onError,
            ),
            MaoButton(
              onClick: () {
                _firebaseService.logout();
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, "login");
              },
              text: "Yes",
            ),
          ],
        );
      },
    );
  }
}
