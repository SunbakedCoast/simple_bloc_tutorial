import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_bloc_tutorial/src/model/message.dart';

abstract class SimpleBlocEvent extends Equatable {
  List<Object> get props => [];
}

class ButtonPressed extends SimpleBlocEvent{}

class LoadData extends SimpleBlocEvent{
  final Message message;

  LoadData({this.message});

  List<Object> get props => [message];
}