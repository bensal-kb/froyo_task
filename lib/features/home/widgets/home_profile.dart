import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:foyer/base/base.dart';
import 'package:foyer/features/home/home_vm.dart';
import 'package:foyer/utils/delays.dart';
import 'package:foyer/utils/extensions.dart';
import 'package:foyer/widgets/c_button.dart';
import 'package:foyer/widgets/header.dart';

import '../../../base/base_ui/base_stateless.dart';
import '../../../base/base_vm.dart';

class HomeProfile extends BaseStateless<HomeVM> {
  const HomeProfile({Key? key}) : super(key: key);

  @override
  Widget ui(BuildContext context, vm) {
    bool isLoading = vm.loginState == AppState.loading;
    bool hasUser = vm.user != null;
    return AbsorbPointer(
      absorbing: isLoading,
      child: AnimatedOpacity(
        opacity: isLoading ? 0.4 : 1,
        duration: Delays.mill500,
        child: Card(
          color: theme(context).primaryLight(),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Header('Profile'),
                    if (hasUser)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          latLongRow(
                              context, 'Latitude : ', vm.user?.lat.toString()),
                          const SizedBox(height: 5),
                          latLongRow(context, 'Longitude : ',
                              vm.user?.long.toString()),
                        ],
                      )
                  ],
                ),
                const SizedBox(height: 20),
                if (!hasUser)
                  Center(
                      child: Text(
                    'Please login to view/configure the profile',
                    style: textStyle(
                        fontSize: 16, color: theme(context).warning()),
                  )),
                if (hasUser)
                  Column(
                    children: [
                      Row(
                        children: [
                          hint(context, 'Choose a theme'),
                          Expanded(
                            child: DropdownButton<String>(
                                underline: Container(),
                                isExpanded: true,
                                value: vm.user!.theme,
                                items: ThemeType.values
                                    .map((e) => DropdownMenuItem(
                                          value: e.name,
                                          child: Text(
                                            e.name.capitalize(),
                                            style: textStyle(fontSize: 16),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (val) => vm.setTheme(context, val!)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          hint(context, 'Choose a color'),
                          CButton(
                            onTap: () {
                              pickColor(context, (Color color) {
                                vm.setColor(context, color.value);
                                pop(context);
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(vm.user!.color)),
                            ),
                          ),
                          const SizedBox(),
                        ],
                      ),
                      Builder(builder: (context) {
                        List<int> list = [for (var i = 10; i < 20; i += 1) i];
                        return Row(
                          children: [
                            hint(context, 'Choose a text size'),
                            Expanded(
                              child: DropdownButton<int>(
                                  isExpanded: true,
                                  underline: Container(),
                                  value: vm.user!.textSize,
                                  items: list
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              'Text size $e',
                                              style: textStyle(
                                                  fontSize: e.toDouble()),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (val) =>
                                      vm.setTextSize(context, val!)),
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget latLongRow(context, String title, String? content) {
    return Row(
      children: [
        Text(
          title,
          style: textStyle(fontSize: 14, color: theme(context).titleLight1()),
        ),
        const SizedBox(width: 10),
        Text(
          content ?? '...',
          style: textStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget hint(context, String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Text(
        '$title : ',
        style: textStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  pickColor(context, onColorChange) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
                child: BlockPicker(
              pickerColor: Colors.black,
              onColorChanged: onColorChange,
            ))));
  }
}
