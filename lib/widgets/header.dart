import 'package:flutter/material.dart';

import '../base/base_ui/base_stateless.dart';

class Header extends BaseStateless {
  const Header(this.title, {Key? key,}) : super(key: key);
  final String title;

  @override
  Widget ui(BuildContext context, vm) {
    return Text(
      title,
      style: textStyle(
        color: theme(context).dark(),
        fontSize: 20,
      ),
    );
  }
}
