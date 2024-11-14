import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/event_entity.dart';
import '../repository/event_repository.dart';

class GetEvent implements UseCase<EventEntity, String> {
  final EventRepository eventRepository;

  GetEvent({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, EventEntity>> call(String id) async {
    return await eventRepository.getEvent(id);
  }
}
