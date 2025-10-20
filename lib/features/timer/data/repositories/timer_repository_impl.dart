import 'package:practice_006/features/timer/domain/repositories/timer_repository.dart';
import 'package:practice_006/features/timer/domain/entities/ticker.dart';

/// Implementación concreta del repositorio del temporizador
class TimerRepositoryImpl implements TimerRepository {
  final Ticker _ticker;

  TimerRepositoryImpl(this._ticker);

  @override
  Stream<int> ticker() => _ticker.tick();
}
