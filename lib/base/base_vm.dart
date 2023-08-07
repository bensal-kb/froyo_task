import 'package:flutter/cupertino.dart';

import 'base.dart';

class BaseVM<M> extends ChangeNotifier with Base {
  AppState state = AppState.nothing;
  bool isLoading() => state == AppState.loading;

  bool isNothing() => state == AppState.nothing;

  bool isSuccess() => state == AppState.success;

  bool isError() => state == AppState.error;

  Future refresh() async {
    await delay();
    notifyListeners();
  }

  Future onNothing() async {
      if (isNothing()) {
        state = AppState.loading;
        await delay();
        await delay();
        state = AppState.success;
        notifyListeners();
      }
  }

  setState(AppState state) {
    this.state = state;
    notifyListeners();
  }


  clear() {
    state = AppState.nothing;
  }



}

enum AppState {
  nothing, loading, success, error
}