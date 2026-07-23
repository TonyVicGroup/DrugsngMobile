import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/core/services/dependency_injection_service.dart';
import 'package:drugs_ng/core/widgets/error/app_error_widget.dart';
import 'package:drugs_ng/features/auth/data/datasource/user_preference.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // dont bloat my debug console with every state change
    // log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  DependencyInjectionService.init();
  await Hive.initFlutter().then((_) => UserPreference.init());
  Bloc.observer = const AppBlocObserver();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return AppErrorWidget(details: details);
  };

  await runZonedGuarded<Future<void>>(
    () async {
      runApp(await builder());
    },
    (Object error, StackTrace stack) {
      log('Uncaught error: $error', stackTrace: stack);
    },
  );
}


// Future<void> _initOneSignal() async {
//   await NotificationService.initialize(
//     appId: dotenv.get('ONESIGNAL_APP_ID'),
//     restApiKey: dotenv.env['ONESIGNAL_REST_API_KEY'] ?? '',
//     requestPermission: true,
//   );
// }

