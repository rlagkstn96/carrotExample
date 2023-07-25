import 'package:beamer/beamer.dart';
import 'package:carrotexample/constants/common_size.dart';
import 'package:carrotexample/screens/home/items_page.dart';
import 'package:carrotexample/states/user_notifier.dart';
import 'package:carrotexample/widgets/expandable_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../router/locations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomSelectedIndex,
        children: [
          ItemsPage(),
          Container(
            color: Colors.accents[0],
          ),
          Container(
            color: Colors.accents[3],
          ),
          Container(
            color: Colors.accents[6],
          ),
          Container(
            color: Colors.accents[9],
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 90,
        children: [
          MaterialButton(
            onPressed: () {
              context.beamToNamed('/$LOCATION_INPUT');
            },
            height: 56,
            shape: CircleBorder(),
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add),
          ),
          MaterialButton(
            onPressed: () {},
            height: 24,
            shape: CircleBorder(),
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add),
          ),
          MaterialButton(
            onPressed: () {},
            height: 24,
            shape: CircleBorder(),
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add),
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: false,
        title:
            Text('남가좌동', style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          IconButton(
              onPressed: () {
                // context.read<UserProvider>().setUserAuth(false);
              },
              icon: Icon(CupertinoIcons.search)),
          IconButton(
              onPressed: () {
                // context.read<UserProvider>().setUserAuth(false);
              },
              icon: Icon(CupertinoIcons.text_justify)),
          IconButton(
              onPressed: () {
                // context.read<UserProvider>().setUserAuth(false);
              },
              icon: Icon(CupertinoIcons.bell)),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(CupertinoIcons.square_arrow_left)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSelectedIndex,
        // type: BottomNavigationBarType.fixed, //bottomNavBar 글씨 보이기
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 0
                  ? 'assets/imgs/home_dark.png'
                  : 'assets/imgs/home.png')),
              label: '홈'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 0
                  ? 'assets/imgs/placeholder.png'
                  : 'assets/imgs/selected_placeholder.png')),
              label: '내 근처 '),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 0
                  ? 'assets/imgs/chat.png'
                  : 'assets/imgs/chat_selected.png')),
              label: '채팅'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/imgs/more.png')),
              label: '내정보'),
        ],
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
      ),
    );
  }
}
