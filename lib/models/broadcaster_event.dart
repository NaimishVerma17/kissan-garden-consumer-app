import 'package:kissan_garden/services/broadcaster_service.dart';
import 'package:meta/meta.dart';

class BroadcasterEvent {
  dynamic data;
  BroadcasterEventType eventType;

  BroadcasterEvent({@required this.eventType, this.data});
}
