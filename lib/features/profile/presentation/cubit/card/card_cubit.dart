import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/profile/data/models/debit_card.dart';
import 'package:drugs_ng/features/profile/data/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class CardState extends Equatable {
  final List<DebitCard> cards;
  final LoadStatusEnum status;
  final AppError? error;
  final int pageNumber;

  const CardState(this.cards, this.status, this.pageNumber, [this.error]);

  factory CardState.initial() => const CardState([], LoadStatusEnum.initial, 1);

  CardState copy({
    List<DebitCard>? cards,
    LoadStatusEnum? status,
    AppError? error,
    int? pageNumber,
  }) => CardState(
    cards ?? this.cards,
    status ?? this.status,
    pageNumber ?? this.pageNumber,
    error,
  );

  @override
  List<Object> get props => [cards, status, pageNumber, error ?? ''];
}

class CardCubit extends Cubit<CardState> {
  final ProfileRepository repo = ProfileRepository();
  static const int pageSize = 20;
  CardCubit() : super(CardState.initial());

  Future<AppError?> addCard(DebitCard card) async {
    AppError? errorResponse;
    emit(state.copy(status: LoadStatusEnum.loading));
    final result = await repo.addCard(card);
    result.fold(
      (error) {
        errorResponse = error;
        emit(state.copy(error: error, status: LoadStatusEnum.failed));
      },
      (result) {
        emit(
          state.copy(
            cards: [...state.cards, card],
            status: LoadStatusEnum.success,
          ),
        );
      },
    );
    return errorResponse;
  }

  Future<void> deleteCard(DebitCard card) async {
    emit(state.copy(status: LoadStatusEnum.loading));
    final result = await repo.addCard(card);
    result.fold(
      (error) {
        emit(state.copy(error: error, status: LoadStatusEnum.failed));
      },
      (result) {
        emit(
          state.copy(
            cards: state.cards..where((cd) => cd != card),
            status: LoadStatusEnum.success,
          ),
        );
      },
    );
  }

  Future<void> getCards() async {
    emit(state.copy(status: LoadStatusEnum.loading));
    final result = await repo.getCards(
      PageFilter(pageNumber: state.pageNumber, pageSize: pageSize),
    );
    result.fold(
      (error) {
        emit(state.copy(error: error, status: LoadStatusEnum.failed));
      },
      (result) {
        emit(
          state.copy(
            cards: result,
            pageNumber: 1,
            status: LoadStatusEnum.success,
          ),
        );
      },
    );
  }

  Future<void> fetchMoreCards({bool showLoader = true}) async {
    if (showLoader) {
      emit(state.copy(status: LoadStatusEnum.loading));
    }
    final result = await repo.getCards(
      PageFilter(pageNumber: state.pageNumber + 1, pageSize: pageSize),
    );
    result.fold(
      (error) {
        emit(state.copy(error: error, status: LoadStatusEnum.failed));
      },
      (result) {
        emit(
          state.copy(
            cards: state.cards..addAll(result),
            pageNumber: state.pageNumber + 1,
            status: LoadStatusEnum.success,
          ),
        );
      },
    );
  }

  void resetData() {
    emit(CardState.initial());
  }
}
