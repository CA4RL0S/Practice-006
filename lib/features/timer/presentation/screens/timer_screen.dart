import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_006/features/timer/application/timer_bloc.dart';
import 'package:practice_006/features/timer/data/repositories/timer_repository_impl.dart';
import 'package:practice_006/features/timer/domain/entities/ticker.dart';
import 'package:practice_006/features/timer/presentation/widgets/timer_view.dart';

/// The TimerScreen class is a StatelessWidget that provides a TimerBloc to its child TimerView.
class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(timerRepository: TimerRepositoryImpl(Ticker())),
      child: const TimerView(),
    );
  }
}