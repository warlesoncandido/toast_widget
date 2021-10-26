import 'package:flutter/material.dart';

import 'enum/widget_toast_position.dart';

class WidgetToast {
  static show(
    context, {
    WidgetToastPosition toastPosition = WidgetToastPosition.bottom,
    bool onTapClose = false,
    @required Function(BuildContext context) builder,
    Duration duration = const Duration(seconds: 2),
  }) async {
    final overlayState = Overlay.of(context);
    OverlayEntry overlay;
    var alignment;
    switch (toastPosition) {
      case WidgetToastPosition.top:
        alignment = Alignment.topCenter;
        break;
      case WidgetToastPosition.center:
        alignment = Alignment.center;
        break;
      case WidgetToastPosition.bottom:
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

  static cancel(BuildContext context) {
    var overlay = OverlayEntry(builder: (context) => Container());
    overlay.remove();
  }
}
