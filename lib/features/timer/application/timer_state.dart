part of 'timer_bloc.dart';

/// The `sealed class TimerState extends Equatable` in Dart is defining a base class `TimerState` that
/// is marked as `sealed`. In Dart, a sealed class restricts its subclasses to be defined in the same
/// file. This helps in ensuring that all possible subclasses of `TimerState` are known and handled
sealed class TimerState extends Equatable {
  const TimerState({required this.duration, this.initialDuration, this.laps = const []});

  final int duration;
  final int? initialDuration;
  final List<int> laps;

  @override
  List<Object> get props => [duration, initialDuration ?? 0, ...laps];
}

class TimerInitial extends TimerState {
  const TimerInitial({required int duration})
      : super(duration: duration, initialDuration: duration);
}

class TimerTicking extends TimerState {
  const TimerTicking({
    required int duration,
    int? initialDuration,
    List<int> laps = const [],
  }) : super(duration: duration, initialDuration: initialDuration, laps: laps);
}

class TimerFinished extends TimerState {
  const TimerFinished() : super(duration: 0, initialDuration: 0, laps: const []);
}

