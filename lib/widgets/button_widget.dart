import 'package:flutter/cupertino.dart';
import 'package:foyer/base/base_vm.dart';
import 'package:lottie/lottie.dart';

import '../base/base_ui/base_stateful.dart';
import '../utils/delays.dart';
import '../vm/empty_vm.dart';

typedef ValidatorType = bool Function();

class ButtonWidget extends StatefulWidget {
  const ButtonWidget(
      {Key? key,
      required this.title,
      this.onPressed,
      this.validate,
      this.height = 55,
      this.enabled = true,
      this.state,})
      : super(key: key);
  final String title;
  final Function? onPressed;
  final double? height;
  final bool enabled;
  final AppState? state;
  final ValidatorType? validate;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends BaseStateful<ButtonWidget, EmptyVM> {
  bool showWarning = false;
  bool isLoading = false;
  bool isSuccess = false;
  bool isError = false;
  AppState state = AppState.nothing;

  @override
  Widget ui(BuildContext context) {
    if (widget.state != null) {
      setData();
    }
    return AbsorbPointer(
      absorbing: state == AppState.loading,
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: widget.enabled ? onPressed : onPressedWhenDisabled,
          child: AnimatedContainer(
            key: Key('$isLoading $isSuccess $isError'),
            duration: Delays.mill300,
            curve: Curves.fastEaseInToSlowEaseOut,
            margin: EdgeInsets.symmetric(horizontal: showWarning ? 10 : 0),
            height: widget.height,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.99, -0.15),
                end: const Alignment(-0.99, 0.15),
                colors: theme(context).primaryGradients(),
              ),
              shadows: [
                BoxShadow(
                    color: showWarning
                        ? theme(context).warning().withOpacity(0.2)
                        : theme(context).primary().withOpacity(0.2),
                    offset: const Offset(3, 3),
                    spreadRadius: 1,
                    blurRadius: 3)
              ],
              shape: isLoading || isSuccess || isError
                  ? const CircleBorder()
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          showWarning ? 20 : 15),
                    ),
            ),
            child: AnimatedDefaultTextStyle(
                duration: Delays.mill300,
                style: textStyle(
                        color: showWarning
                            ? theme(context).warning()
                            : theme(context).light(),
                        fontSize: 18,
                      ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: Delays.mill300,
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    child: Builder(
                        key: Key('$isLoading $isSuccess $isError'),
                        builder: (context) {
                          return isLoading
                              ? Lottie.asset(
                                  'assets/lottie/loading.json',
                                )
                              : isSuccess
                                  ? Lottie.asset('assets/lottie/done.json',
                                      repeat: false)
                                  : isError
                                      ? Lottie.asset('assets/lottie/error.json',
                                          repeat: false)
                                      : SizedBox(
                                          key: const Key('title'),
                                          child: Text(widget.title));
                        }),
                  ),
                )),
          )),
    );
  }

  onPressed() async {
    removeFocus(context);
    if (widget.validate != null) {
      if (!widget.validate!()) {
        onPressedWhenDisabled();
        return;
      }
    }
    if (widget.onPressed != null) {
      await widget.onPressed!();
    }
  }

  onPressedWhenDisabled() {
    showWarning = true;
    setState(() {});
    Future.delayed(Delays.mill500, () {
      showWarning = false;
      setState(() {});
    });
  }

  setData() {
    if (widget.state != state) {
      clear();
      if (widget.state! == AppState.loading) {
        setState(() {
          isLoading = true;
        });
        state = AppState.loading;
      } else if (widget.state == AppState.success) {
        setSuccess();
        state = AppState.success;
      } else if (widget.state! == AppState.error) {
        setError();
        state = AppState.error;
      }
    }
  }

  clear() {
    isLoading = false;
    isSuccess = false;
    isError = false;
  }

  setSuccess() {
    isSuccess = true;
    Future.delayed(Delays.sec2, () {
      isSuccess = false;
      if (mounted) {
        setState(() {});
      }
    });
  }

  setError() {
    isError = true;
    Future.delayed(Delays.sec2, () {
      setState(() {
        isError = false;
      });
    });
    Future.delayed(Delays.mill300, () {
      if (!mounted) {
        isError = false;
      }
    });
  }
}
