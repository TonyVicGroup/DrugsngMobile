import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationTabCubit extends Cubit<bool> {
  NavigationTabCubit() : super(false);

  void hide() => emit(true);
  void show() => emit(false);
}
