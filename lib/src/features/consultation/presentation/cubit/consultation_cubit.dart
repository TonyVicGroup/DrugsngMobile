import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'consultation_state.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  ConsultationCubit() : super(ConsultationInitial());
}
