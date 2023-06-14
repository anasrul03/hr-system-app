import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fire_auth_state.dart';

class FireAuthCubit extends Cubit<FireAuthState> {
  FireAuthCubit() : super(FireAuthInitial());
}
