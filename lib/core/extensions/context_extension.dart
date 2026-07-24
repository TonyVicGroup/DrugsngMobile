import 'package:drugs_ng/core/widgets/popup/animated_bottom_modal_widget.dart';
import 'package:drugs_ng/core/widgets/popup/animated_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ContextExtension on BuildContext {
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  Future<T?> pushNamedWithResult<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed<T>(this, routeName, arguments: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(this, routeName, arguments: arguments);
  }

  void pop([Object? result]) {
    Navigator.pop(this, result);
  }

  void pushNamedAndRemoveUntil(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  void push(Widget widget) {
    Navigator.push(this, MaterialPageRoute<void>(builder: (context) => widget));
  }

  void pushReplacement(Widget widget) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute<void>(builder: (context) => widget),
    );
  }

  bool canPop() {
    return Navigator.canPop(this);
  }

  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  ThemeData get theme => Theme.of(this);
  // ExtraColors get extraColors => Theme.of(this).extension<ExtraColors>()!;
  bool get isOnScreen {
    final route = ModalRoute.of(this);
    final isCurrentRoute = route?.isCurrent ?? false;
    return isCurrentRoute;
  }

  EdgeInsets get appPadding => MediaQuery.of(this).padding;

  Future<T?> showPopup<T>(
    Widget child, {
    bool barrierDismissible = true,
    bool useRootNavigator = true,
    bool fullBleed = false,
    bool animatePopup = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (context) => AnimatedPopupWidget(child: child),
    );
  }

  Future<T?> showBottomModal<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool useRootNavigator = true,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      builder: (context) => AnimatedBottomModalWidget(child: child),
    );
  }

  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    bool isError = false,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
        duration: duration,
      ),
    );
  }
}
