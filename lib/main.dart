import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_tutorial/bloc/simple_bloc.dart';
import 'package:simple_bloc_tutorial/src/repository/message_repository.dart';

void main() => runApp(
  //put the repository and propagate it down to the tree
  RepositoryProvider<MessageRepository>(
    create: (context) {
      return MsgRepo();
    },
    //same logic with above
    child: BlocProvider<SimpleBlocBloc>(
      create: (context) {
        final msgRepo = RepositoryProvider.of<MessageRepository>(context);
        return SimpleBlocBloc(msgRepo);
      },
      child: SimpleBloc(),
    )));

class SimpleBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _simpleBloc = BlocProvider.of<SimpleBlocBloc>(context);

    //will add the event when pressed
    _buttonPressed() {
      _simpleBloc.add(ButtonPressed());
    } 

    return MaterialApp(
      title: 'Simple Bloc Tutorial',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Simple Bloc'),
          ),
          body: BlocBuilder<SimpleBlocBloc, SimpleBlocState>(
              builder: (context, state) {
            if (state is MessageInitial) {
              print(state.toString());
              return Center(
                child: RaisedButton(
                  
                  onPressed: state is Loading ? () {} : _buttonPressed,
                  child: Text('TAP ME!'),
                ),
              );
            }
            if (state is Loading) {
              return _loading();
            }
            if (state is MessageLoaded) {
              final message = state.message;
              return _messageLoaded(message.value);
            }
          })),
    );
  }

  //WIDGETS, I JUST BASICALLY MADE IT SHORT 
  //I LIKE CLEAN CODES 
  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _button(VoidCallback function){
    return Center(
      child: RaisedButton(
        onPressed: function,
        child: Text('Tap Me!'),
      ),
    );
  }

  Widget _messageLoaded(String message) {
    return Center(
      child: Text(message),
    );
  }
}
