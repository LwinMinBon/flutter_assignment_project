import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/event_entity.dart';
import '../repository/event_repository.dart';

class GetAllEvents implements UseCase<List<EventEntity>, NoParams> {
  final EventRepository eventRepository;

  GetAllEvents({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, List<EventEntity>>> call(NoParams params) async {
    return await eventRepository.getAllEvents();
  }
}