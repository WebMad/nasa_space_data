import 'dart:async';

//базовый класс для всех bloc
abstract class BlocBase<State, Event> {
  //текущее состояние bloc'а
  State _state;

  //геттер, состояния
  get state => _state;

  //конструктор класса, принимает начальное состояние bloc'а
  BlocBase(this._state);

  //контроллер потока для событий
  final _eventController = StreamController<Event>.broadcast();

  //воронка для публикации события
  Sink<Event> get inEvent => _eventController.sink;

  //поток для отслежования событий
  Stream<Event> get _outEvent => _eventController.stream;

  //контроллер потока состояний
  final _stateController = StreamController<State>.broadcast();

  //воронка для публикации новых состояний блока
  Sink<State> get _inState => _stateController.sink;

  //поток для отслеживания новых состояний
  Stream<State> get outState => _stateController.stream;

  //функция для добавления слушателя событий
  void on<E extends Event>(Function(E) handler) {
    _outEvent.listen((event) {
      if (event is E) {
        handler(event);
      }
    });
  }

  //фнукция для добавляения нового события в bloc
  void emit(State state) {
    _state = state;
    _inState.add(state);
  }

  //функция, вызываемая при уничтожении виджета, закрывает потоки
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
