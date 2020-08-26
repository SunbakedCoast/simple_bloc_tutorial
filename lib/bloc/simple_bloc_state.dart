import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_bloc_tutorial/bloc/simple_bloc.dart';
import 'package:simple_bloc_tutorial/src/model/message.dart';

abstract class SimpleBlocState extends Equatable {
  List<Object> get props => [];
}

class MessageInitial extends SimpleBlocState{}

class Loading extends SimpleBlocState{}

class MessageLoaded extends SimpleBlocState{
  final Message message;

  MessageLoaded(this.message);

  List<Object> get props => [message];
}