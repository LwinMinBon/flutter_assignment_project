import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entity/event_entity.dart';

abstract interface class EventRepository {
  Future<Either<Failure, EventEntity>> createEvent({
    required File imageFile,
    required String userId,
    required String name,
    required String description,
    required List<String> topics,
    required String location,
    required String venueName,
    required List<String> coordinates,
    required String date,
    required String time,
  });
  Future<Either<Failure, List<EventEntity>>> getAllEvents();
  Future<Either<Failure, EventEntity>> getEvent(String id);
  Future<Either<Failure, Unit>> removeEvent(String id);
}
