import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/remove_event.dart';

part 'event_removal_event.dart';
part 'event_removal_state.dart';

class EventRemovalBloc extends Bloc<EventRemovalEvent, EventRemovalState> {
  final RemoveEvent _removeEvent;

  EventRemovalBloc({
    required RemoveEvent removeEvent,
  })  : _removeEvent = removeEvent,
        super(EventRemovalInitial()) {
    on<EventRemove>((event, emit) async {
      emit(EventRemovalLoading());
      final result = await _removeEvent(event.eventId);
      result.fold((error) {
        emit(EventRemovalFailure(errorMessage: error.message));
      }, (unit) {
        emit(EventRemovalSuccess());
      });
    });
  }
}
