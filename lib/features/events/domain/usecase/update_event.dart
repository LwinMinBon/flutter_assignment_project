import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/event_entity.dart';
import '../repository/event_repository.dart';

class UpdateEvent implements UseCase<Unit, EventEntity> {
  final EventRepository eventRepository;

  UpdateEvent({required this.eventRepository,});

  @override
  Future<Either<Failure, Unit>> call(EventEntity eventEntity) async {
    return await eventRepository.updateEvent(eventEntity);
  }

}
