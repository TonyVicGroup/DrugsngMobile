import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/src/tab_overlay.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';

part "profile_setup_state.dart";

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  final AuthRepository repo;

  ProfileSetupCubit(this.repo) : super(ProfileSetupInitial());

  Future createAccount(AuthUserProfile profile) async {
    emit(ProfileSetupLoading());
    final result = await repo.setupProfile(profile);

    result.fold(
      (left) => emit(ProfileSetupError(left.message)),
      (right) async {
        emit(ProfileSetupUpdated());
        await acceptPermission();
      },
    );
  }

  Future acceptPermission() async {
    final location = Location();
    PermissionStatus permission = await location.requestPermission();
    if (permission == PermissionStatus.denied) {
      emit(const ProfileSetupPermissionDenied(
          "Location permission is required"));
    } else {
      emit(ProfileSetupPermissionGranted());
      AppUtils.navKey.currentState?.pushAndRemoveUntil(
        PageTransition(
          type: PageTransitionType.fade,
          child: const TabOverlay(),
          duration: const Duration(milliseconds: 600),
        ),
        (route) => route.isFirst,
      );
    }
  }
}
