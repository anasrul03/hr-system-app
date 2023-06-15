import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_app/routes/app_route_address.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  String location;
  ScaffoldWithNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  static const List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.dashboard_outlined),
      activeIcon: Icon(Icons.dashboard),
      label: 'HOME',
      initialLocation: homePage,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.receipt_long_outlined),
      activeIcon: Icon(Icons.receipt_long),
      label: 'Claim',
      initialLocation: claimPage,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.monetization_on_outlined),
      activeIcon: Icon(Icons.monetization_on_rounded),
      label: 'Payroll',
      initialLocation: payrollPage,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.account_circle),
      activeIcon: Icon(Icons.storefront),
      label: 'Account',
      initialLocation: accountPage,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontFamily: 'Roboto');
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        selectedItemColor: const Color(0xFF434343),
        selectedFontSize: 12,
        unselectedItemColor: const Color(0xFF838383),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _goOtherTab(context, index);
        },
        currentIndex: _currentIndex,
        // currentIndex: widget.location == homePage
        //     ? 0
        //     : widget.location == claimPage
        //         ? 1
        //         : widget.location == payrollPage
        //             ? 3
        //             : 4,
        items: tabs,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _currentIndex = index;
    });
    if (index == 2) {
      context.push(payrollPage);
    } else {
      router.push(location);
    }
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem(
      {required this.initialLocation,
      required Widget icon,
      String? label,
      Widget? activeIcon})
      : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}
