import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lab_test_state.dart';

class LabTestCubit extends Cubit<LabTestState> {
  LabTestCubit() : super(LabTestInitial());
}
