
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rizaapp/screen/tab_homepage.dart';
import 'package:rizaapp/screen/tab_setting.dart';

import 'tab_customer_device_list_page.dart';

class HomePageSeleted extends StatefulWidget {
  final int seletedIndex;
  const HomePageSeleted(this.seletedIndex, {Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageSeleted> {
  // initialize global widget
  late PageController _pageController;

// Pages if you click bottom navigation
  final List<Widget> _contentPages = <Widget>[
    const TabHomePage(),
    const CustomerV2Page(),

    const TabSettingPage(),
  ];

  int _currentIndex = 0;
  @override
    initState()  {
    super.initState();
    _currentIndex = widget.seletedIndex;
    _pageController = PageController(initialPage: widget.seletedIndex);
    _pageController.addListener(_handleTabSelection);
  }
  void _handleTabSelection() {
    setState(() {
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _contentPages.map((Widget content) {
            return content;
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (value) {
            _currentIndex = value;
            _pageController.jumpToPage(value);
            // this unfocus is to prevent show keyboard in the wishlist page when focus on search text field
            FocusScope.of(context).unfocus();
          },
          selectedFontSize: 8,
          unselectedFontSize: 8,
          iconSize: 36,
          items: const [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                    Icons.home,
                )
            ),
            BottomNavigationBarItem(
                label: 'Devices',
                icon: Icon(
                  Icons.group,
                )
            ),
            BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(
                    Icons.settings,
                )
            ),
          ],
        ),
      ),
    );
  }
}
