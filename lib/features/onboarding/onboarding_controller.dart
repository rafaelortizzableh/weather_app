import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/core.dart';

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, bool>((ref) {
  final _prefs = ref.watch(sharedPreferencesServiceProvider);
  return OnboardingController(_prefs);
});

class OnboardingController extends StateNotifier<bool> {
  final SharedPreferencesService _sharedPreferencesService;

  OnboardingController(this._sharedPreferencesService)
      : super(_sharedPreferencesService.getOnboardingDone ?? false);

  Future<void> setOnboardingAsDone() async {
    try {
      final savedToSharedPrefs =
          await _sharedPreferencesService.saveOnboardingCompleted(true);
      state = savedToSharedPrefs;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void checkIfOnboardingIsDone() {
    try {
      final onBoardingDone = _sharedPreferencesService.getOnboardingDone;
      if (onBoardingDone == true) {
        state = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
