import 'package:mobx/mobx.dart';

part 'progress.g.dart';

class Progress = _Progress with _$Progress;

abstract class _Progress with Store {

  @observable
  double progress = 0;

  @action
  void upProgress(){
    progress+=0.01;
  }

  @action
  void downProgress(){
    progress-=0.1;
  }

}