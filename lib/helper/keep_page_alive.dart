import 'package:flutter/material.dart';

class KeepAliveWrapper extends StatefulWidget {
  final bool keepAlive;
  final Widget child;

  const KeepAliveWrapper({Key? key, this.keepAlive = true, required this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KeepAliveWrapperState();
  }
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    // Called when the state changes
    if (oldWidget.keepAlive != widget.keepAlive) {
      // to update KeepAlive state
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
