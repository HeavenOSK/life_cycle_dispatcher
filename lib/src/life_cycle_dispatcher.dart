import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

typedef DispatchCallback<S> = void Function(Store<S> store);

class LifeCycleDispatcher<S> extends StatefulWidget {
  const LifeCycleDispatcher({
    @required this.store,
    @required this.child,
    this.onInitDispatches = const [],
    this.onDisposeDispatches = const [],
    Key key,
  })  : assert(store != null),
        assert(onInitDispatches != null),
        assert(onDisposeDispatches != null),
        super(key: key);

  final Store<S> store;
  final List<DispatchCallback<S>> onInitDispatches;
  final List<DispatchCallback<S>> onDisposeDispatches;
  final Widget child;

  @override
  _LifeCycleDispatcherState createState() => _LifeCycleDispatcherState();
}

class _LifeCycleDispatcherState extends State<LifeCycleDispatcher> {
  @override
  void initState() {
    super.initState();

    for (final dispatch in widget.onInitDispatches) {
      dispatch(widget.store);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (final dispatch in widget.onDisposeDispatches) {
      dispatch(widget.store);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
