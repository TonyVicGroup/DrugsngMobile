import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lab_appointment_state.dart';

class LabAppointmentCubit extends Cubit<LabAppointmentState> {
  LabAppointmentCubit() : super(LabAppointmentInitial());
}
