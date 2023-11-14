import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../../Event/obscure_bloc_event.dart';
part '../../State/obscure_bloc_state.dart';

class ObscureBlocBloc extends Bloc<ObscureBlocEvent, ObscureBlocState> {
  ObscureBlocBloc() : super(ObscureVisibleState(isVisible: false)) {
    on<ObscureVisibleEvent>(_ChangeVisible);
    // on<ObscureBlocEvent>(_OnOpen);
  }

// Stream<ObscureBlocState> _ChangeVisible(ObscureBlocEvent event) async* {
//     if(event is ObscureVisibleEvent){
//       final currState = state as ObscureVisibleState;
//       print("iNi curr : $currState");
//       yield ObscureVisibleState(isVisible: !currState.isVisible);
//     }
//   }
  

  void _ChangeVisible(ObscureVisibleEvent event, Emitter<ObscureBlocState> emit) {
      var currState = state as ObscureVisibleState;
      if(state is ObscureVisibleState){
        emit(
          ObscureVisibleState(isVisible: !currState.isVisible)
        );
      }

  }
}
