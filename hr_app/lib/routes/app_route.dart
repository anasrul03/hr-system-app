import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_app/cubit/routes_cubit/routes_cubit.dart';
import 'package:hr_app/routes/app_route_address.dart';
import 'package:hr_app/view/Account.dart';
import 'package:hr_app/view/LeaveAppDetails.dart';
import 'package:hr_app/view/LeaveApplication.dart';
import 'package:hr_app/view/MainScreen.dart';
import 'package:hr_app/view/NotFound.dart';
import 'package:hr_app/view/Payroll.dart';
import 'package:hr_app/view/PayrollDetails.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: leavePage,
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: [
    //ShellRoute is stay on one page
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        // print(state.location);
        return BlocProvider(
          create: (context) => RoutesCubit(),
          child: MainScreen(
            screen: child,
          ),
        );
      },
      routes: [
        GoRoute(
            path: leavePage,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: LeaveAppScreen(),
              );
            },
            routes: [
              GoRoute(
                path: leaveDetailPage,
                builder: (context, state) {
                  return const LeaveDetailScreen();
                },
              )
            ]),
        GoRoute(
          path: payrollPage,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: PayrollScreen(),
            );
          },
          routes: [
            GoRoute(
              path: payrollDetailPage,
              builder: (context, state) {
                return const PayrollDetailScreen();
              },
            )
          ],
        ),
        GoRoute(
          path: accountPage,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Center(
                child: AccountLayout(),
              ),
            );
          },
        ),
      ],
    ),
    //New Page
    // GoRoute(
    //   parentNavigatorKey: _rootNavigatorKey,
    //   path: accountPage,
    //   pageBuilder: (context, state) {
    //     return NoTransitionPage(
    //       key: UniqueKey(),
    //       child: const AccountLayout(),
    //     );
    //   },
    // ),
  ],
  errorBuilder: (context, state) {
    return const NotFound();
  },
);
