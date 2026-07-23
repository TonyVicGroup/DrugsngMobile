import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'lab_state.dart';

class LabCubit extends Cubit<LabState> {
  LabCubit() : super(LabInitial());
}
