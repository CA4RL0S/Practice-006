import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:practice_006/features/timer/domain/repositories/timer_repository.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({required TimerRepository timerRepository})
      : _timerRepository = timerRepository,
        super(const TimerInitial(duration: _duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerReset>(_onReset);
    on<TimerLapPressed>(_onLapPressed); // registrar evento de lap
  }

  final TimerRepository _timerRepository;
  static const int _duration = 60;
  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerTicking(
      duration: event.duration,
      initialDuration: event.duration,
    ));
    _tickerSubscription?.cancel();
    _tickerSubscription = _timerRepository
        .ticker()
        .listen((ticks) => add(TimerTicked(duration: event.duration - ticks)));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    if (event.duration > 0) {
      final currentState = state;
      emit(TimerTicking(
        duration: event.duration,
        initialDuration: currentState.initialDuration,
        laps: currentState.laps,
      ));
    } else {
      emit(const TimerFinished());
    }
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerTicking) {
      _tickerSubscription?.pause();
      emit(TimerInitial(duration: state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(duration: _duration));
  }

  void _onLapPressed(TimerLapPressed event, Emitter<TimerState> emit) {
  // Hacemos cast seguro a TimerTicking
    if (state is TimerTicking) {
      final tickingState = state as TimerTicking;

      final newLaps = List<int>.from(tickingState.laps)
        ..add(tickingState.duration);

      emit(TimerTicking(
        duration: tickingState.duration,
        initialDuration: tickingState.initialDuration,
        laps: newLaps,
      ));
    }
  }
}