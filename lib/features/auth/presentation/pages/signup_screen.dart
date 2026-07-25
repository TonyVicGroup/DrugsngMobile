import 'package:drugs_ng/core/enum/gender_enum.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/signup_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/widgets/create_account_tab.dart';
import 'package:drugs_ng/features/auth/presentation/widgets/setup_profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();

  static Route<dynamic> route(RouteSettings route) {
    return MaterialPageRoute(builder: (_) => const SignupScreen());
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final emailCntrl = TextEditingController();
  final firstNameCntrl = TextEditingController();
  final lastNameCntrl = TextEditingController();
  final password1Cntrl = TextEditingController();
  final password2Cntrl = TextEditingController();
  final createAccountForm = GlobalKey<FormState>();
  final setupProfileForm = GlobalKey<FormState>();
  late final PageController controller;

  ValueNotifier<DateTime?> birthDay = ValueNotifier<DateTime?>(null);
  ValueNotifier<GenderEnum> gender = ValueNotifier<GenderEnum>(GenderEnum.male);
  ValueNotifier<bool> obscurePassword1 = ValueNotifier<bool>(true);
  ValueNotifier<bool> obscurePassword2 = ValueNotifier<bool>(true);
  ValueNotifier<bool> acceptTerms = ValueNotifier<bool>(false);
  ValueNotifier<bool> acceptTermsHasError = ValueNotifier<bool>(false);
  ValueNotifier<bool> weeklyUpdates = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    firstNameCntrl.dispose();
    lastNameCntrl.dispose();
    emailCntrl.dispose();
    password1Cntrl.dispose();
    password2Cntrl.dispose();
    // dispose value notifiers
    obscurePassword1.dispose();
    obscurePassword2.dispose();
    acceptTerms.dispose();
    acceptTermsHasError.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            CreateAccountTab(
              controller: controller,
              email: emailCntrl,
              password1: password1Cntrl,
              password2: password2Cntrl,
              formKey: createAccountForm,
              obscurePassword1: obscurePassword1,
              obscurePassword2: obscurePassword2,
              acceptTerms: acceptTerms,
              acceptTermsHasError: acceptTermsHasError,
              weeklyUpdates: weeklyUpdates,
            ),
            SetupProfileTab(
              controller: controller,
              firstName: firstNameCntrl,
              lastName: lastNameCntrl,
              email: emailCntrl,
              birthDay: birthDay,
              gender: gender,
              formKey: setupProfileForm,
            ),
          ],
        ),
      ),
    );
  }
}
