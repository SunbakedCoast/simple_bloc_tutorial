import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_tutorial/main.dart';
import 'package:simple_bloc_tutorial/src/repository/message_repository.dart';

import 'simple_bloc.dart';

class SimpleBlocBloc extends Bloc<SimpleBlocEvent, SimpleBlocState>{
  final MessageRepository _messageRepository;
  //listens to incoming stream
  StreamSubscription _streamSubscription;

  SimpleBlocBloc(MessageRepository messageRepository)
  : assert(messageRepository != null),
  _messageRepository = messageRepository, super(MessageInitial());


  //will map all the events into states
  @override
  Stream<SimpleBlocState> mapEventToState(SimpleBlocEvent event) async* {
    //will execute the statement inside when the event is called;
   if(event is ButtonPressed){
   yield*  _mapButtonPressedToState(event);
   }
   if(event is LoadData){
    yield* _mapLoadDataToStaate(event);
   }
  }

  Stream<SimpleBlocState> _mapButtonPressedToState(ButtonPressed event) async* {
    yield Loading();
    //just a simulated delay
    await Future.delayed(Duration(seconds: 2));
    //if stream is nul,l cancel
    _streamSubscription?.cancel();

    //will get the value or future from the messageRepository and convert it as stream
    _streamSubscription = _messageRepository.getName().asStream().listen((msg) { 
      //add a new event which is loadData and pass the value from the stream
      //into the event value
      add(LoadData(message: msg));
    });
  }

  Stream<SimpleBlocState> _mapLoadDataToStaate(LoadData event) async* {
    //get the event value and pass it to the state value 
    //which can be retrieved by the ui using the state value.
    yield MessageLoaded(event.message);
  }

  
}