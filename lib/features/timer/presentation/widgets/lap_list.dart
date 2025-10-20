import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_006/features/timer/application/timer_bloc.dart';

class LapList extends StatelessWidget {
  const LapList({super.key});

  @override
  Widget build(BuildContext context) {
    final laps = context.select((TimerBloc bloc) => bloc.state.laps);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: laps.length,
      itemBuilder: (context, index) {
        final lap = laps[index];
        final minutesStr = ((lap / 60) % 60).floor().toString().padLeft(2, '0');
        final secondsStr = (lap % 60).floor().toString().padLeft(2, '0');
        return ListTile(
          title: Text('Lap ${index + 1}: $minutesStr:$secondsStr'),
        );
      },
    );
  }
}
