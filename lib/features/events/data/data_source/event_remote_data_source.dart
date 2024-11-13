import 'dart:io';

import '../model/event_model.dart';

abstract interface class EventRemoteDataSource {
  Future<String> uploadEventImage(EventModel eventModel, File imageFile);
  Future<EventModel> createEvent(EventModel eventModel);

}