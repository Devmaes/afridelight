import 'package:flutter/services.dart';

class AudioFeedbackService {
  Future<void> playTap() async {
    await SystemSound.play(SystemSoundType.click);
    await HapticFeedback.selectionClick();
  }

  Future<void> playSuccess() async {
    await SystemSound.play(SystemSoundType.click);
    await HapticFeedback.lightImpact();
  }

  void dispose() {}
}
