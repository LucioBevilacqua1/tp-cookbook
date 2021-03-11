import 'package:frontend/src/core/base_model.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:logging/logging.dart';

class HomeModel extends BaseModel {
  final Logger log = Logger('HomeModel');
  ViewState viewState;
  onModelReady() async {
    viewState = ViewState.Busy;
    viewState = ViewState.Idle;
    notifyListeners();
  }
}
