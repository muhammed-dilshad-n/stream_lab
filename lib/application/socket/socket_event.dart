part of 'socket_bloc.dart';

@freezed
class SocketEvent with _$SocketEvent {
  const factory SocketEvent.connectButtonPressed({
    required dynamic connectionKey,
    required Connection connection,
  }) = _ConnectButtonPressed;
  const factory SocketEvent.disconnectButtonPresssed() =
      _DisconnectButtonPresssed;
  const factory SocketEvent.onConnected({
    required String connectionUrl,
    required List<Event> eventListeners,
  }) = _OnConnected;
  const factory SocketEvent.onConnectError({
    required SocketFailure failure,
  }) = _OnConnectError;
  const factory SocketEvent.onDisConnected({
    required String connectionUrl,
  }) = _OnDisConnected;
  const factory SocketEvent.onError({
    required SocketFailure failure,
  }) = _OnError;
  const factory SocketEvent.onNewResponse({
    required EventFormData event,
  }) = _OnNewResponse;
  const factory SocketEvent.clearAllResponses() = _ClearAllResponses;
  const factory SocketEvent.eventEmitted({
    required Event event,
  }) = _EventEmitted;
  const factory SocketEvent.listeningStartedForAllActiveListeners({
    required List<Event> eventListeners,
  }) = _ListeningStartedForAllActiveListeners;
}
