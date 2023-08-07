import 'package:flutter/material.dart';
import '../base.dart';
import '../base_vm.dart';
import 'base_ui.dart';

abstract class BaseStateless<VM extends BaseVM> extends StatelessWidget
    with Base, BaseUI<VM> {
  const BaseStateless({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (getVM(context) != null) {
      return wrapWithProvider(context, (context) {
        return ui(context, thisVM(context));
      });
    }
    return ui(context, thisVM(context));
  }

  Widget ui(
      BuildContext context, VM vm);


}

