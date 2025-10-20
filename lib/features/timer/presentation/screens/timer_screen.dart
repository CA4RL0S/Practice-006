import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:practice_006/features/timer/application/timer_bloc.dart';
import 'package:practice_006/features/timer/data/repositories/timer_repository_impl.dart';
import 'package:practice_006/features/timer/domain/entities/ticker.dart';
import 'package:practice_006/features/timer/presentation/widgets/timer_view.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer(); // Inicializamos el reproductor

    return BlocProvider(
      create: (_) => TimerBloc(timerRepository: TimerRepositoryImpl(Ticker())),
      child: BlocListener<TimerBloc, TimerState>(
        listener: (context, state) {
          // Reproduce sonido cuando el timer termina
          if (state is TimerFinished) {
            player.setAsset('assets/sounds/beep.wav').then((_) {
              player.play();
            });
          }
        },
        child: const TimerView(), // Aquí está la UI del temporizador
      ),
    );
  }
}
