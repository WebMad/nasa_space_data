import 'package:flutter/material.dart';
import 'package:nasa_space_data/common/bloc_base.dart';

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final Widget child;
  late final T bloc;

  BlocProvider({Key? key, required this.child, bloc})
      : bloc = bloc(), super(key: key);

  @override
  State<BlocProvider> createState() => _BlocProviderState();

  static T of<T extends BlocBase>(BuildContext context) {
    BlocProvider<T> provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>()!;
    return provider.bloc;
  }
}

class _BlocProviderState extends State<BlocProvider<BlocBase>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
