// lib/core/app/timer_app.dart

import 'package:flutter/material.dart';
import 'package:practice_006/core/theme/app_theme.dart';
import 'package:practice_006/features/timer/presentation/screens/timer_screen.dart';

/// TimerApp es el widget principal que envuelve la pantalla del temporizador
/// dentro de un MaterialApp con el tema de la aplicación.
class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer App',
      theme: AppTheme().getTheme(),
      home: const TimerScreen(),
    );
  }
}
