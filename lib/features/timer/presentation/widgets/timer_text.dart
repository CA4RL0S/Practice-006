import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_006/features/timer/application/timer_bloc.dart';

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TimerBloc>().state;
    final duration = state.duration;
    final initialDuration = state.initialDuration ?? 60; // Valor por defecto si no existe

    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    // Aseguramos que progress sea un double entre 0.0 y 1.0
    final progress = (initialDuration > 0 ? duration / initialDuration : 0.0).clamp(0.0, 1.0).toDouble();

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 8,
          ),
        ),
        GestureDetector(
          onTap: () async {
            if (state is TimerInitial) {
              final result = await showDialog<int>(
                context: context,
                builder: (_) => _DurationInputDialog(initial: duration),
              );
              if (result != null) {
                context.read<TimerBloc>().add(TimerStarted(duration: result));
              }
            }
          },
          child: Text(
            '$minutesStr:$secondsStr',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}

class _DurationInputDialog extends StatefulWidget {
  final int initial;
  const _DurationInputDialog({required this.initial});

  @override
  State<_DurationInputDialog> createState() => _DurationInputDialogState();
}

class _DurationInputDialogState extends State<_DurationInputDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Duration (seconds)'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, int.tryParse(_controller.text)),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
