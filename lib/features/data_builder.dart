import 'package:flutter/widgets.dart';

class DataBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T) onData;

  const DataBuilder({
    Key key,
    this.future,
    this.onData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return onData(snapshot.data);
        }

        return Container();
      },
    );
  }
}

