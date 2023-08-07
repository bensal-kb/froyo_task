import 'package:flutter/cupertino.dart';

import '../base/base_ui/base_stateless.dart';

class CButton extends BaseStateless {
  const CButton(
      {Key? key,
        required this.onTap,
        required this.child,
        this.height,
        this.width,
        this.padding})
      : super(key: key);
  final VoidCallback? onTap;
  final Widget child;
  final double? height, width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget ui(BuildContext context, vm) {
    return SizedBox(
      height: height,
      width: width,
      child: CupertinoButton(
        onPressed: onTap,
        padding: padding ?? const EdgeInsets.all(0),
        child: child,
      ),
    );
  }
}
