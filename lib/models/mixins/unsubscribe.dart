import 'package:rxdart/rxdart.dart';

class UnsubscribeMixin {
  PublishSubject<bool> distroy$ = PublishSubject();

  void onDispose() async{
    distroy$.add(true);
    await distroy$.close();
  }
}
