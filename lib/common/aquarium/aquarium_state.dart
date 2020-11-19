import 'package:mobx/mobx.dart';

part 'aquarium_state.g.dart';

class AquariumState = _AquariumState with _$AquariumState;

abstract class _AquariumState with Store {
  @observable
  double progress = 0;

  @computed
  bool get isAnimationEnabled => progress > 0 && progress < 1;

  @action
  void upProgress() {
    progress += 0.01;
  }

  @action
  void downProgress() {
    progress -= 0.0005;
  }
}
