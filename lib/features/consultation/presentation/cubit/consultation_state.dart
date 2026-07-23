part of 'consultation_cubit.dart';

abstract class ConsultationState extends Equatable {
  final ConsultationHomeData homeData;
  final List<ConsultationDetails> consultations;
  final ConsultationParameters params;
  const ConsultationState(this.consultations, this.params, this.homeData);

  @override
  List<Object> get props => [consultations, params, homeData];
}

class ConsultationStateInitial extends ConsultationState {
  ConsultationStateInitial()
      : super(
          [],
          ConsultationParameters.initial(),
          ConsultationHomeData.initial(),
        );
}

class ConsultationStateLoading extends ConsultationState {
  const ConsultationStateLoading(
    super.consultations,
    super.params,
    super.homeData,
  );
}

class ConsultationStateSuccess extends ConsultationState {
  const ConsultationStateSuccess(
    super.consultations,
    super.params,
    super.homeData,
  );
}

class ConsultationStateError extends ConsultationState {
  final AppError error;
  const ConsultationStateError(
    this.error,
    super.consultations,
    super.params,
    super.homeData,
  );
}
