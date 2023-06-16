// import 'package:androidrouting/controller/navigation_cubit.dart';
// import 'package:androidrouting/presentation/shared/named_nav_bar_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_app/cubit/routes_cubit/routes_cubit.dart';
import 'package:hr_app/routes/app_route_address.dart';

import '../components/namedNavBarItem.dart';

// import '../core/utils/constants.dart';

class MainScreen extends StatelessWidget {
  final Widget screen;

  MainScreen({Key? key, required this.screen}) : super(key: key);

  final tabs = [
    NamedNavigationBarItemWidget(
      initialLocation: leavePage,
      icon: const Icon(Icons.leave_bags_at_home),
      label: 'Leave',
    ),
    NamedNavigationBarItemWidget(
      initialLocation: payrollPage,
      icon: const Icon(Icons.payments),
      label: 'Payroll',
    ),
    NamedNavigationBarItemWidget(
      initialLocation: accountPage,
      icon: const Icon(Icons.account_box),
      label: 'Account',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(context, tabs),
    );
  }
}

BlocBuilder<RoutesCubit, RoutesCubitState> _buildBottomNavigation(
        mContext, List<NamedNavigationBarItemWidget> tabs) =>
    BlocBuilder<RoutesCubit, RoutesCubitState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (value) {
            if (state.index != value) {
              context.read<RoutesCubit>().getNavBarItem(value);
              context.go(tabs[value].initialLocation);
            }
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(
            size: ((IconTheme.of(mContext).size)! * 1.3),
          ),
          items: tabs,
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
        );
      },
    );
