import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../base.dart';
import '../base_vm.dart';
import 'base_ui.dart';

abstract class BaseStateful<BW extends StatefulWidget, VM extends BaseVM>
    extends State<BW> with Base, BaseUI<VM> {
  late VM vm;

  @override
  Widget build(context) {
    if (getVM(context) != null) {
      return wrapWithProvider(context, (context) {
        return buildUI(context);
      });
    }
    return buildUI(context);
  }

  Widget buildUI(context){
    vm = thisVM(context);
    return ui(context);
  }

  Widget ui(BuildContext context);

  void init() {}

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

}
