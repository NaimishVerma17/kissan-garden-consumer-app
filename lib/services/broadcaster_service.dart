import 'package:kissan_garden/models/broadcaster_event.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

class BroadcasterService {
  BroadcasterService._();

  static final BroadcasterService _instance = new BroadcasterService._();

  factory BroadcasterService.getInstance() => _instance;

  final PublishSubject<BroadcasterEvent> _publishSubject = PublishSubject();

  void emit({@required BroadcasterEventType eventType, dynamic data}) {
    _publishSubject.add(BroadcasterEvent(eventType: eventType, data: data));
  }

  Observable<dynamic> on(BroadcasterEventType eventType) {
    return new Observable(_publishSubject.stream).where((BroadcasterEvent e) {
      return e.eventType == eventType;
    }).map((BroadcasterEvent e) {
      return e.data;
    });
  }
}

enum BroadcasterEventType {
  loginComplete,
  bootstrapped,
  logout,
  addressChanged
}
