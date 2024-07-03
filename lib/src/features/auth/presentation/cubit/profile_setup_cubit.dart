import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/auth/data/models/auth_user_profile.dart';
import 'package:drugs_ng/src/features/auth/data/repositories/auth_repository.dart';
import 'package:drugs_ng/src/tab_overlay.dart';
import 'package:either_dart/either.dart';
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
    final result = repo.setupProfile(authProfile: profile);
    result.fold((left) {
      emit(ProfileSetupState.failed);
    }, (right) async {
      emit(ProfileSetupState.updated);
      await acceptPermission();
    });
  }

  Future acceptPermission() async {
    Location location = Location();
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.denied) {
        emit(ProfileSetupState.permissionDenied);
      } else {
        emit(ProfileSetupState.permissionGranted);
        AppUtils.navKey.currentState?.pushAndRemoveUntil(
            PageTransition(
              type: PageTransitionType.fade,
              child: const TabOverlay(),
              duration: const Duration(milliseconds: 600),
            ),
            (route) => route.isFirst);
      }
    }
  }
}
