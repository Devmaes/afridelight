import 'package:afridelight/core/services/audio_feedback_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioFeedbackProvider = Provider<AudioFeedbackService>((ref) {
  final service = AudioFeedbackService();
  ref.onDispose(service.dispose);
  return service;
});
