import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_app/routes/app_route_address.dart';

part 'routes_state.dart';

class RoutesCubit extends Cubit<RoutesCubitState> {
  RoutesCubit()
      : super(const RoutesCubitState(bottomNavItems: leavePage, index: 0));

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(const RoutesCubitState(bottomNavItems: leavePage, index: 0));
        break;
      case 1:
        emit(const RoutesCubitState(bottomNavItems: payrollPage, index: 1));
        break;
      case 2:
        emit(const RoutesCubitState(bottomNavItems: accountPage, index: 2));
        break;
    }
  }
}
