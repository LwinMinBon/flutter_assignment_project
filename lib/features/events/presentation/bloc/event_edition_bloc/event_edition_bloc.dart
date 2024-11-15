import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/event_entity.dart';
import '../../../domain/usecase/update_event.dart';

part 'event_edition_event.dart';
part 'event_edition_state.dart';

class EventEditionBloc extends Bloc<EventEditionEvent, EventEditionState> {
  final UpdateEvent _updateEvent;

  EventEditionBloc({
    required UpdateEvent updateEvent,
  })  : _updateEvent = updateEvent,
        super(EventEditionInitial()) {
    on<EventEdit>((event, emit) async {
      emit(EventEditionLoading());
      final result = await _updateEvent(event.eventEntity);
      result.fold(
        (error) {
          emit(EventEditionFailure(errorMessage: error.message));
        },
        (unit) {
          emit(EventEditionSuccess());
        },
      );
    });
  }
}
