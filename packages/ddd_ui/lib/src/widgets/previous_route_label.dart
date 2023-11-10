import 'package:ddd_ui/src/observers/previous_route_observer.dart';
import 'package:flutter/material.dart';

class PreviousRouteLabel extends StatelessWidget {
  final TextStyle? textStyle;
  const PreviousRouteLabel({
    super.key,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final name = PreviousRouteObserver.value?.settings.name;
    return name != null
        ? Text(
            'Back to $name',
            style: textStyle ?? Theme.of(context).textTheme.bodySmall,
          )
        : Container();
  }
}
