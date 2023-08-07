import 'package:flutter/material.dart';
import '../base/base_ui/base_stateless.dart';
import '../utils/delays.dart';

class FieldWidget extends BaseStateless{
  const FieldWidget(
      {Key? key,
      this.controller,
      this.hintText,
      this.maxLength,
      this.onChanged,
      this.validator,
      this.keyboardType})
      : super(key: key);
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLength;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget ui(BuildContext context, vm) {
    return FormField<String>(
        validator: (str) {
          if(validator!=null&&controller!=null) {
            return validator!(controller!.text);
          }
          return null;
        },
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: theme(context).light(),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: theme(context).shadow(),
                      blurRadius: 30,
                      offset: const Offset(
                        1, 1
                      )
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        onChanged: (str) {
                          state.reset();
                          if (maxLength != null && maxLength == str.length) {
                            removeFocus(context);
                          }
                          if (onChanged != null) {
                            onChanged!(str);
                          }
                        },
                        style: textStyle(
                            fontSize: 20,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600),
                        keyboardType: keyboardType,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,

                            hintText: hintText,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            hintStyle: textStyle(
                                fontSize: 16,
                                color: theme(context).hint(),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSize(
                duration: Delays.mill300,
                curve: Curves.easeInOut,
                alignment: Alignment.centerLeft,
                child: !state.hasError
                    ? Container()
                    : Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 5),
                      child: Builder(builder: (context) {
                        return Text(
                          state.errorText!,
                          style: textStyle(
                              fontSize: 12,
                              color: theme(context).warning(),
                              fontWeight: FontWeight.w400),
                        );
                      }),
                    ),
              )
            ],
          );
        });
  }
}
