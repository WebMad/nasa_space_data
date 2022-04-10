import 'package:flutter/material.dart';
import 'package:nasa_space_data/common/bloc_base.dart';

//виджет для поставвки класса bloc между вложенными виджетами
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  //дочерний элемент
  final Widget child;

  //класс для доставки
  late final T bloc;

  BlocProvider({Key? key, required this.child, bloc})
      : bloc = bloc(),
        super(key: key);

  @override
  State<BlocProvider> createState() => _BlocProviderState();

  //функция для получения блока в дереве виджетов
  static T of<T extends BlocBase>(BuildContext context) {
    BlocProvider<T> provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>()!;
    return provider.bloc;
  }
}

//состояние виджета
class _BlocProviderState extends State<BlocProvider<BlocBase>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    //вызов закрытия потоков
    widget.bloc.dispose();
    super.dispose();
  }
}
