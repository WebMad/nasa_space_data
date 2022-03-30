import 'dart:async';

abstract class BlocBase<State, Event> {
  State _state;

  get state => _state;

  BlocBase(this._state);

  final _eventController = StreamController<Event>.broadcast();

  Sink<Event> get inEvent => _eventController.sink;

  Stream<Event> get _outEvent => _eventController.stream;

  final _stateController = StreamController<State>.broadcast();

  Sink<State> get _inState => _stateController.sink;

  Stream<State> get outState => _stateController.stream;

  void on<E extends Event>(Function(E) handler) {
    _outEvent.listen((event) {
      if (event is E) {
        handler(event);
      }
    });
  }

  void emit(State state) {
    _state = state;
    _inState.add(state);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
