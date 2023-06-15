import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_app/main.dart';
import 'package:hr_app/routes/app_route_address.dart';
import 'package:hr_app/view/Account.dart';
import 'package:hr_app/view/Home.dart';
import 'package:hr_app/view/Login.dart';

import '../cores/bottomNavigationBar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    // GoRoute(
    //   path: login,
    //   parentNavigatorKey: _rootNavigatorKey,
    //   pageBuilder: (context, state) {
    //     return const NoTransitionPage(
    //       child: MyHomePage(
    //         title: 'test',
    //       ),
    //     );
    //   },
    // ),
    //ShellRoute is stay on one page
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        print(state.location);
        return NoTransitionPage(
            child: ScaffoldWithNavBar(
          location: state.location,
          child: child,
        ));
      },
      routes: [
        GoRoute(
          path: homePage,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: Center(child: Text("Home")),
              ),
            );
          },
        ),
        GoRoute(
          path: claimPage,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: Center(child: Text("Claim page!")),
              ),
            );
          },
        ),
        GoRoute(
            path: payrollPage,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Scaffold(
                  body: Center(child: Text("Payroll page!")),
                ),
              );
            }),
      ],
    ),
    //New Page
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: accountPage,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: UniqueKey(),
          child: const AccountLayout(),
        );
      },
    ),
  ],
);
