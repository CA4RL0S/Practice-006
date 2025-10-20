import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_006/features/timer/application/timer_bloc.dart';

/// The `ActionsButtons` class is a stateless widget that displays different action buttons
/// based on the state of a `TimerBloc` in a Flutter application.
class ActionsButtons extends StatelessWidget {
  const ActionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              // Estado inicial: solo mostrar play
              TimerInitial() => [
                FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context.read<TimerBloc>().add(
                        TimerStarted(duration: state.duration),
                      ),
                ),
              ],

              // Estado corriendo: pausa, reset y lap
              TimerTicking() => [
                FloatingActionButton(
                  child: const Icon(Icons.pause),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerPaused()),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.flag),
                  tooltip: 'Lap',
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerLapPressed()),
                ),
              ],

              // Estado finalizado: solo reset
              TimerFinished() => [
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],
            },
          ],
        );
      },
    );
  }
}
