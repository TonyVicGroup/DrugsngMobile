import 'package:drugs_ng/core/enum/account_type_enum.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabNavigationCubit extends Cubit<TabNavigationState> {
  TabNavigationCubit(this._authCubit) : super(TabNavigationState()) {
    _authCubit.stream.listen((st) {
      emit(state.copyWith(accountType: st.accountType));
    });
    emit(state.copyWith(accountType: _authCubit.state.accountType));
  }

  final AuthCubit _authCubit;

  void setTab(int tabIndex) {
    emit(state.copyWith(tabIndex: tabIndex));
  }
}

class TabNavigationState extends Equatable {
  const TabNavigationState({
    this.tabIndex = 0,
    this.accountType = AccountTypeEnum.patient,
  });

  final int tabIndex;
  final AccountTypeEnum accountType;

  TabNavigationState copyWith({int? tabIndex, AccountTypeEnum? accountType}) {
    return TabNavigationState(
      tabIndex: tabIndex ?? this.tabIndex,
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  List<Object?> get props => [tabIndex, accountType];
}
