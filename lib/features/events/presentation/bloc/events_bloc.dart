import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entity/event_entity.dart';
import '../../domain/usecase/get_all_events.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final GetAllEvents _getAllEvents;

  EventsBloc({
    required GetAllEvents getAllEvents,
  })  : _getAllEvents = getAllEvents,
        super(EventsInitial()) {
    on<EventsGetAll>(_onEventsGetAll);
  }

  void _onEventsGetAll(EventsGetAll event, Emitter<EventsState> emit) async {
    emit(EventsLoading());
    final result = await _getAllEvents(NoParams());
    result.fold(
      (error) {
        emit(EventsFailure(errorMessage: error.message));
      },
      (eventEntity) {
        emit(EventsSuccess(eventEntities: eventEntity));
      },
    );
  }
}
