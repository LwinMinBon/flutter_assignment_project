import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/event_entity.dart';
import '../../domain/usecase/create_event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final CreateEvent _createEvent;

  EventBloc({
    required CreateEvent createEvent,
  })  : _createEvent = createEvent,
        super(EventInitial()) {
    on<EventCreate>(_onEventCreate);
  }

  void _onEventCreate(EventCreate event, Emitter<EventState> emit) async {
    emit(EventLoading());
    final result = await _createEvent(
      UploadEventParams(
        imageFile: event.imageFile,
        userId: event.userId,
        name: event.name,
        description: event.description,
        topics: event.topics,
        location: event.location,
        venueName: event.venueName,
        coordinates: event.coordinates,
        date: event.date,
        time: event.time,
      ),
    );
    result.fold(
      (error) {
        emit(EventFailure(message: error.message));
      },
      (eventEntity) {
        emit(EventSuccess(eventEntity: eventEntity));
      },
    );
  }
}
