import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_lab/core/constants.dart';
import 'package:stream_lab/domain/connection/failures/connection_failure.dart';
import 'package:stream_lab/domain/connection/i_connection_repository.dart';
import 'package:stream_lab/domain/connection/models/connection.dart';
import 'package:stream_lab/domain/connection/models/connection_form_data.dart';
import 'package:stream_lab/domain/connection/models/connection_value_objects.dart';
import 'package:stream_lab/domain/event/models/event_form_data.dart';
import 'package:stream_lab/domain/event/models/event_value_objects.dart';

part 'connection_form_event.dart';
part 'connection_form_state.dart';
part 'connection_form_bloc.freezed.dart';

@injectable
class ConnectionFormBloc
    extends Bloc<ConnectionFormEvent, ConnectionFormState> {
  final IConnectionRepository _connectionRepository;
  ConnectionFormBloc(this._connectionRepository)
      : super(ConnectionFormState.initial()) {
    on<ConnectionFormEvent>((event, emit) async {
      await event.map(
        initialize: (_) async => emit(ConnectionFormState.initial()),
        connectionNameChanged: (e) async => emit(state.copyWith(
          isSaved: false,
          connectionFormData: state.connectionFormData?.copyWith(
            connectionName: ConnectionName(e.connectionName),
          ),
          failureOrSucessOption: none(),
        )),
        connectionUrlChanged: (e) async => emit(state.copyWith(
          isSaved: false,
          connectionFormData: state.connectionFormData?.copyWith(
            connectionUrl: ConnectionURL(e.connectionUrl),
          ),
          failureOrSucessOption: none(),
        )),
        connectionSelected: (e) async => emit(state.copyWith(
          isSubmitting: false,
          isSaved: true,
          showValidationError: false,
          connectionKey: e.connection.key,
          connectionFormData: e.connection.toDomain(),
          emitterIndex: null,
          listenerIndex: null,
          failureOrSucessOption: none(),
        )),
        newConnectionButtonPressed: (_) async => emit(state.copyWith(
          isSubmitting: false,
          isSaved: false,
          showValidationError: false,
          connectionKey: null,
          connectionFormData: ConnectionFormData.empty(),
          emitterIndex: null,
          listenerIndex: null,
          failureOrSucessOption: none(),
        )),
        addEvent: (e) async {
          if (e.type == EventType.emitter) {
            emit(state.copyWith(
              isSaved: false,
              emitterIndex: state.connectionFormData?.eventEmitters.length,
              connectionFormData: state.connectionFormData?.copyWith(
                eventEmitters: [
                  ...state.connectionFormData?.eventEmitters ?? [],
                  EventFormData.empty().copyWith(type: e.type),
                ],
              ),
              showValidationError: false,
              failureOrSucessOption: none(),
            ));
          } else {
            emit(state.copyWith(
              isSaved: false,
              listenerIndex: state.connectionFormData?.eventListeners.length,
              connectionFormData: state.connectionFormData?.copyWith(
                eventListeners: [
                  ...state.connectionFormData?.eventListeners ?? [],
                  EventFormData.empty().copyWith(type: e.type),
                ],
              ),
              showValidationError: false,
              failureOrSucessOption: none(),
            ));
          }
        },
        emitterSelected: (e) async => emit(state.copyWith(
          showValidationError: false,
          emitterIndex: e.emitterIndex,
          failureOrSucessOption: none(),
        )),
        listenerSelected: (e) async => emit(state.copyWith(
          showValidationError: false,
          listenerIndex: e.listenerIndex,
          failureOrSucessOption: none(),
        )),
        unSelectListener: (_) async => emit(state.copyWith(
          listenerIndex: null,
        )),
        emitterNameChanged: (e) async => emit(state.copyWith(
          isSaved: false,
          connectionFormData: state.connectionFormData?.copyWith(
            eventEmitters: state.connectionFormData!.eventEmitters
                .asMap()
                .entries
                .map(
                  (entry) => entry.key == state.emitterIndex
                      ? state.connectionFormData!
                          .eventEmitters[state.emitterIndex!]
                          .copyWith(name: EventName(e.name))
                      : entry.value,
                )
                .toList(),
          ),
          failureOrSucessOption: none(),
        )),
        emitterDataTypeChanged: (e) async => emit(state.copyWith(
          isSaved: false,
          connectionFormData: state.connectionFormData?.copyWith(
            eventEmitters: state.connectionFormData!.eventEmitters
                .asMap()
                .entries
                .map(
                  (entry) => entry.key == state.emitterIndex
                      ? state.connectionFormData!
                          .eventEmitters[state.emitterIndex!]
                          .copyWith(dataType: e.dataType)
                      : entry.value,
                )
                .toList(),
          ),
          failureOrSucessOption: none(),
        )),
        emitterDataChanged: (e) async => emit(state.copyWith(
          isSaved: false,
          connectionFormData: state.connectionFormData?.copyWith(
            eventEmitters: state.connectionFormData!.eventEmitters
                .asMap()
                .entries
                .map(
                  (entry) => entry.key == state.emitterIndex
                      ? state.connectionFormData!
                          .eventEmitters[state.emitterIndex!]
                          .copyWith(data: EventData(e.data))
                      : entry.value,
                )
                .toList(),
          ),
          failureOrSucessOption: none(),
        )),
        listenerNameChanged: (e) async => emit(state.copyWith(
          isSaved: false,
          connectionFormData: state.connectionFormData?.copyWith(
            eventListeners: state.connectionFormData!.eventListeners
                .asMap()
                .entries
                .map(
                  (entry) => entry.key == state.listenerIndex
                      ? state.connectionFormData!
                          .eventEmitters[state.listenerIndex!]
                          .copyWith(name: EventName(e.name))
                      : entry.value,
                )
                .toList(),
          ),
          failureOrSucessOption: none(),
        )),
        listenerSwitchToggled: (e) async => emit(state.copyWith(
          isSaved: false,
          connectionFormData: state.connectionFormData?.copyWith(
            eventListeners: state.connectionFormData!.eventListeners
                .asMap()
                .entries
                .map(
                  (entry) => entry.key == e.listenerIndex
                      ? state.connectionFormData!.eventEmitters[e.listenerIndex]
                          .copyWith(isEnabled: e.value)
                      : entry.value,
                )
                .toList(),
          ),
          failureOrSucessOption: none(),
        )),
        saveButtonPressed: (_) async {
          Either<ConnectionFailure, Unit>? failureOrSuccess;
          EventFormData? eventEmitter;
          EventFormData? eventListener;

          emit(state.copyWith(
            isSubmitting: true,
            showValidationError: false,
            failureOrSucessOption: none(),
          ));

          if (state.emitterIndex != null) {
            eventEmitter =
                state.connectionFormData!.eventEmitters[state.emitterIndex!];
          }

          if (state.listenerIndex != null) {
            eventListener =
                state.connectionFormData!.eventListeners[state.listenerIndex!];
          }

          if (state.connectionFormData != null &&
              state.connectionFormData!.failureOption.isNone() &&
              (eventEmitter == null || eventEmitter.failureOption.isNone()) &&
              (eventListener == null || eventListener.failureOption.isNone())) {
            if (state.connectionKey == null) {
              final option = await _connectionRepository.createConnection(
                connection: Connection.fromDomain(
                  state.connectionFormData!,
                ),
              );

              if (option.isRight()) {
                emit(state.copyWith(connectionKey: option.getOrElse(() => 0)));
              }

              failureOrSuccess = option.fold(
                (l) => left(l),
                (r) => right(unit),
              );
            } else {
              failureOrSuccess = await _connectionRepository.updateConnection(
                key: state.connectionKey,
                connection: Connection.fromDomain(
                  state.connectionFormData!,
                ),
              );
            }
          }

          emit(state.copyWith(
            isSubmitting: false,
            showValidationError: true,
            isSaved: failureOrSuccess?.isRight() ?? false,
            failureOrSucessOption: optionOf(failureOrSuccess),
          ));
        },
      );
    });
  }
}
