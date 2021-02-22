import 'package:flutter/material.dart';

import 'enum/toast_position.dart';

class Toast {
  static show(
    context, {
    GToastPosition toastPosition = GToastPosition.bottom,
    @required Function(BuildContext context) builder,
    Duration duration = const Duration(seconds: 2),
  }) async {
    final overlayState = Overlay.of(context);
    var alignment;
    switch (toastPosition) {
      case GToastPosition.top:
        alignment = Alignment.topCenter;

        break;
      case GToastPosition.center:
        alignment = Alignment.center;
        break;
      case GToastPosition.bottom:
        alignment = Alignment.bottomCenter;
        break;
      default:
    }

    var overlay = OverlayEntry(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Align(
              alignment: alignment,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Builder(
                  builder: builder,
                ),
              ),
            )
          ],
        ),
      );
    });

    overlayState.insert(overlay);
    Future.delayed(duration).then((_) {
      overlay.remove();
    });
  }
}
