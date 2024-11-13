import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/exception/exceptions.dart';
import '../../domain/entity/event_entity.dart';
import '../../domain/repository/event_repository.dart';
import '../data_source/event_remote_data_source.dart';
import '../model/event_model.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource eventRemoteDataSource;
  EventRepositoryImpl({
    required this.eventRemoteDataSource,
  });
  @override
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
  }) async {
    try {
      EventModel eventModel = EventModel(
        id: const Uuid().v1(),
        updatedAt: DateTime.now(),
        userId: userId,
        name: name,
        description: description,
        imageUrl: "",
        topics: topics,
        location: location,
        venueName: venueName,
        coordinates: coordinates,
        date: date,
        time: time,
      );
      final imageUrl = await eventRemoteDataSource.uploadEventImage(eventModel, imageFile);
      eventModel = eventModel.copyWith(
        imageUrl: imageUrl
      );
      final eventModelResponse = await eventRemoteDataSource.createEvent(eventModel);
      return right(EventEntity.fromModel(eventModelResponse));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
