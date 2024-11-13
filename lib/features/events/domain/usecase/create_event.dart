import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/event_entity.dart';
import '../repository/event_repository.dart';

class CreateEvent implements UseCase<EventEntity, UploadEventParams> {
  final EventRepository eventRepository;

  CreateEvent({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, EventEntity>> call(UploadEventParams params) async {
    return await eventRepository.createEvent(
      imageFile: params.imageFile,
      userId: params.userId,
      name: params.name,
      description: params.description,
      topics: params.topics,
      location: params.location,
      venueName: params.venueName,
      coordinates: params.coordinates,
      date: params.date,
      time: params.time,
    );
  }
}

class UploadEventParams {
  final File imageFile;
  final String userId;
  final String name;
  final String description;
  final List<String> topics;
  final String location;
  final String venueName;
  final List<String> coordinates;
  final String date;
  final String time;

  UploadEventParams({
    required this.imageFile,
    required this.userId,
    required this.name,
    required this.description,
    required this.topics,
    required this.location,
    required this.venueName,
    required this.coordinates,
    required this.date,
    required this.time,
  });
}