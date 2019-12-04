import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

typedef DispatchCallback<S> = void Function(Store<S> store);

class LifeCycleDispatcher<S> extends StatefulWidget {
  const LifeCycleDispatcher({
    @required this.store,
    @required this.child,
    this.onInitDispatch = const [],
    this.onDisposeDispatch = const [],
    Key key,
  })  : assert(store != null),
        assert(onInitDispatch != null),
        assert(onDisposeDispatch != null),
        super(key: key);

  final Store<S> store;
  final List<DispatchCallback<S>> onInitDispatch;
  final List<DispatchCallback<S>> onDisposeDispatch;
  final Widget child;

  @override
  _LifeCycleDispatcherState createState() => _LifeCycleDispatcherState();
}

class _LifeCycleDispatcherState extends State<LifeCycleDispatcher> {
  @override
  void initState() {
    super.initState();

    for (final dispatch in widget.onInitDispatch) {
      dispatch(widget.store);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (final dispatch in widget.onDisposeDispatch) {
      dispatch(widget.store);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
