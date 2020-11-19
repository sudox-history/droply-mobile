import 'package:mobx/mobx.dart';

part 'aquarium_state.g.dart';

class AquariumState = _AquariumState with _$AquariumState;

abstract class _AquariumState with Store {
  @observable
  double progress = 0;

  @action
  void upProgress() {
    progress += 0.005;
  }

  @action
  void downProgress() {
    progress -= 0.005;
  }
}
