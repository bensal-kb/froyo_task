import 'package:flutter/cupertino.dart';

import '../../../base/base_ui/base_stateless.dart';
import '../../../widgets/c_button.dart';

class HomeNewUserPrompt extends BaseStateless {
  const HomeNewUserPrompt({Key? key}) : super(key: key);

  @override
  Widget ui(BuildContext context, vm) {
    return CupertinoAlertDialog(
      title: Text('Create a fresh profile ?', style: textStyle(fontSize: 18),),
      content: const Text('Profile for provided \n data doesn\'t exist!'),
      actions: [
        CButton(
            onTap: () => pop(context, false),
            child: Text(
              'NO',
              style: textStyle(color: theme(context).warning()),
            )),
        CButton(
            onTap: () => pop(context, true),
            child: Text(
              'YES',
              style: textStyle(),
            )),
      ],
    );
  }
}
