import 'package:drugs_ng/features/auth/domain/entities/auth_credential.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/core/data/models/user_data.dart';
import 'package:equatable/equatable.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  // final AuthRepository authRepo;
  // final DataRepository dataRepo;

  SessionCubit() : super(Unauthenticated());

  // void showSession(AuthCredential credential) async {
  //   try {
  //     UserData user = await dataRepo.getUserById(credential.userId);

  //     if (user == null) {
  //       user = await dataRepo.createUser(
  //         userId: credential.userId,
  //         username: credential.username,
  //         email: credential.email,
  //       );
  //     }

  //     emit(Authenticated(user: user));
  //   } catch (e) {
  //     emit(Unauthenticated());
  //   }
  // }

  // void signOut() {
  //   authRepo.signOut();
  //   emit(Unauthenticated());
  // }
}
