part of '../Bloc/bloc/obscure_bloc_bloc.dart';

abstract class ObscureBlocEvent extends Equatable {
  const ObscureBlocEvent();

  @override
  List<Object> get props => [];
}

class ObscureVisibleEvent extends ObscureBlocEvent{}


// class ObscureOpen extends ObscureBlocEvent{
//   bool isOpen;

//   ObscureOpen({
//     required this.isOpen
//   });

//   @override
//   List<Object> get props => [
//     isOpen
//   ];

// }

// class ObscureHide extends ObscureBlocEvent{
//   bool isOpen;

//   ObscureHide({
//     required this.isOpen
//   });

//   @override
//   List<Object> get props => [
//     isOpen
//   ];
// }
