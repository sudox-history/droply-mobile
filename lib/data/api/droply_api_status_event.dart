abstract class DroplyApiStatusEvent {}

class DroplyApiConnectedEvent implements DroplyApiStatusEvent {
  const DroplyApiConnectedEvent();
}

class DroplyApiNetworkErrorEvent implements DroplyApiStatusEvent {
  const DroplyApiNetworkErrorEvent();
}
