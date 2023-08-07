import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/theme.dart';
import '../../res/themes.dart';
import '../../utils/logs.dart';
import '../base_vm.dart';

mixin class BaseUI<VM extends BaseVM> {
  VM thisVM(context, [bool listen = true]) =>
      Provider.of<VM>(context, listen: listen);

  Themes theme(context, [bool listen = true]) =>
      Provider.of<ThemeModel>(context, listen: listen).currentTheme;

  VM? getVM(context) {
    return null;
  }

  double pt(context, double size) {
    return size * MediaQuery.of(context).textScaleFactor;
  }

  TextStyle textStyle(
      {Color? color,
      double? fontSize,
      FontStyle? fontStyle,
      FontWeight? fontWeight,
      double? height,
      TextDecoration? decoration,
      bool inherit = true,
      double? letterSpacing}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w700,
        decoration: decoration,
        height: height,
        inherit: inherit,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing);
  }

  Widget wrapWithProvider(
      BuildContext context, Widget Function(BuildContext) builder) {
    VM? provider = getVM(context);
    if (provider == null) {
      return Consumer<VM>(builder: (context, vm, widget) => builder(context));
    }
    return ChangeNotifierProvider<VM>(
      create: (BuildContext context) {
        return provider;
      },
      child: Consumer<VM>(builder: (context, vm, widget) => builder(context)),
    );
  }

  removeFocus(context) => FocusManager.instance.primaryFocus?.unfocus();

  Widget loading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget error(BuildContext context, String error) {
    return Text(error);
  }

  Widget page(
      {Widget? body,
      Widget? appBar,
      BoxDecoration? decoration,
      WillPopCallback? onWillPop,
      Widget? bottomNavigationBar,
      String? image}) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          removeFocus(context);
        },
        child: FutureBuilder(
          builder: (
            BuildContext context,
            snapshot,
          ) {
            return Container(
              decoration: decoration ??
                  BoxDecoration(
                      color: theme(context).light(),
                      image: image == null
                          ? null
                          : DecorationImage(
                              image: AssetImage(
                                image,
                              ),
                              fit: BoxFit.fill)),
              child: WillPopScope(
                onWillPop: onWillPop,
                child: Scaffold(
                  appBar: appBar == null ? null : PreferredSize(preferredSize: const Size.fromHeight(kToolbarHeight), child: appBar),
                  backgroundColor: Colors.transparent,
                  body: RefreshIndicator(
                      color: theme(context).primary(),
                      onRefresh: () async {
                        await thisVM(context).refresh();
                      },
                      child: SafeArea(
                        child: Builder(builder: (context) {
                          if (snapshot.hasData || thisVM(context).isSuccess()) {
                            return body ?? Container();
                          } else if (snapshot.hasError) {
                            try {
                              logError(
                                  snapshot.error, Exception(snapshot.error));
                              throw snapshot.error!;
                            } catch (e, stackTrace) {
                              logError(stackTrace);
                              return error(context, e.toString());
                            }
                          }
                          return loading(context);
                        }),
                      )),
                  bottomNavigationBar: bottomNavigationBar,
                ),
              ),
            );
          },
          future:
              thisVM(context).isNothing() ? thisVM(context).onNothing() : null,
        ),
      );
    });
  }
}

enum ImagePathType { images, intro, lottie }
