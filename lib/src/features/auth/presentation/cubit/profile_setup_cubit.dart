import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/src/tab_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';

enum ProfileSetupState {
  initial,
  failed,
  loading,
  updated,
  permissionDenied,
  permissionGranted
}

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  final AuthRepository repo;

  ProfileSetupCubit(this.repo) : super(ProfileSetupState.initial);

  Future createAccount(AuthUserProfile profile) async {
    emit(ProfileSetupState.loading);
    final result = await repo.setupProfile(profile);

    result.fold(
      (left) => emit(ProfileSetupState.failed),
      (right) async {
        emit(ProfileSetupState.updated);
        await acceptPermission();
      },
    );
  }

  Future acceptPermission() async {
    final location = Location();
    PermissionStatus permission = await location.requestPermission();
    if (permission == PermissionStatus.denied) {
      emit(ProfileSetupState.permissionDenied);
    } else {
      emit(ProfileSetupState.permissionGranted);
      AppUtils.navKey.currentState?.pushAndRemoveUntil(
        PageTransition(
          type: PageTransitionType.fade,
          child: const TabOverlay(),
          duration: AppUtils.kPageTransitionDuration,
        ),
        (route) => route.isFirst,
      );
    }
  }
}
