import 'package:flutter/material.dart';

import 'enum/toast_position.dart';

class Toast {
  static show(
    context, {
    GToastPosition toastPosition = GToastPosition.bottom,
    bool onTapClose = false,
    @required Function(BuildContext context) builder,
    Duration duration = const Duration(seconds: 2),
  }) async {
    final overlayState = Overlay.of(context);
    OverlayEntry overlay;
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

    overlay = OverlayEntry(
      builder: (context) {
        return Align(
          alignment: alignment,
          child: GestureDetector(
            onTap: () {
              if (onTapClose) {
                overlay.remove();
                overlay = null;
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Builder(
                builder: builder,
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlay);

    Future.delayed(duration).then(
      (_) {
        if (overlay != null) {
          overlay.remove();
        }
      },
    );
  }
}
