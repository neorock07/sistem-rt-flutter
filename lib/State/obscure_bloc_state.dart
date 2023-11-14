part of '../Bloc/bloc/obscure_bloc_bloc.dart';

abstract class ObscureBlocState extends Equatable {
  const ObscureBlocState();
  
  @override
  List<Object> get props => [];
}

class ObscureVisibleState extends ObscureBlocState{
  final bool isVisible;
  ObscureVisibleState(
    {
      required this.isVisible
    }  
  );
}

// final class ObscureIsOpen extends ObscureBlocState {}

// final class ObscureIsHide extends ObscureBlocState {}


