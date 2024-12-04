import 'dart:math';

import 'package:flutter/material.dart';
import 'package:icon_craft/src/icon_decoration.dart';

/// `IconCraft` is an enhanced implementation of Flutter's native [Icon] widget,
/// designed to provide additional styling and layout features not available in
/// the standard `Icon` widget. This class allows developers to create icons with
/// custom decorations such as borders and gradients, which can be tailored
/// through its [decoration] property.
///
/// The widget supports placing a secondary icon (auxiliary icon) relative to
/// the primary icon with customizable alignment and scaling, making it suitable
/// for creating composite icons. This is especially useful in UIs where icons
/// need to convey combined meanings or interactions, like notifications with
/// alerts, or enhancements indicating active or special statuses.
///
/// ## Features:
/// - **Secondary Icon**: Position a secondary icon in relation to the primary
///   icon with adjustable alignment and size factor. This feature enables the
///   layering of icons to create a single composite visual element.
/// - **Secondary Icon Border Support**: Add distinct borders around icons with customizable
///   size, color, and style.
/// - **Flexible Alignment**: Control the placement of the secondary icon in
///   relation to the primary icon, allowing for precise positioning (e.g., top-right,
///   bottom-left).
///
/// ## Example Usage:
/// ```dart
/// IconCraft(
///   Icon(Icons.email),
///   Icon(Icons.check_circle),
///   decoration: IconDecoration(
///     border: IconBorder(color: Colors.black, width: 2.0),
///   ),
///   alignment: Alignment.topRight,
/// )
/// ```
class IconCraft extends StatelessWidget {
  final Icon icon;
  final Icon secondaryIcon;
  final IconDecoration? decoration;
  final double secondaryIconSizeFactor;
  final Alignment? alignment;
  final double rotation;
  final double secondaryRotation;

  const IconCraft(
    this.icon,
    this.secondaryIcon, {
    Key? key,
    this.decoration,
    this.rotation = 0,
    this.secondaryRotation = 0,
    this.secondaryIconSizeFactor = 0.5,
    this.alignment = Alignment.topRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconData = icon.icon!;
    final secondaryIconData = secondaryIcon.icon!;
    final textDirection = icon.textDirection ?? Directionality.of(context);
    final iconTheme = IconTheme.of(context);
    final iconSize = icon.size ?? iconTheme.size ?? 24.0;
    final secondaryIconSize = iconSize * secondaryIconSizeFactor;
    final iconOpacity = iconTheme.opacity ?? 1.0;
    final border = decoration?.border;

    Color iconColor = icon.color ?? iconTheme.color!;
    if (iconOpacity != 1.0) {
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    }

    final TextStyle iconStyle = TextStyle(
      inherit: false,
      color: iconColor,
      fontSize: iconSize,
      fontFamily: iconData.fontFamily,
      package: iconData.fontPackage,
    );

    final TextStyle secondaryIconStyle = TextStyle(
      inherit: false,
      color: secondaryIcon.color ?? iconColor,
      fontSize: secondaryIconSize,
      fontFamily: secondaryIconData.fontFamily,
      package: secondaryIconData.fontPackage,
    );

    Widget iconWidget = Transform(
      transform: Matrix4.identity()
        ..rotateZ(rotation * pi / 180)
        ..scale(iconData.matchTextDirection && textDirection == TextDirection.rtl ? -1.0 : 1.0, 1.0, 1.0),
      alignment: Alignment.center,
      transformHitTests: false,
      child: RichText(
        overflow: TextOverflow.visible,
        textDirection: textDirection,
        text: TextSpan(
          text: String.fromCharCode(iconData.codePoint),
          style: iconStyle,
        ),
      ),
    );

    Widget secondaryIconWidget = Transform.rotate(
      angle: secondaryRotation * pi / 180, 
      child: RichText(
        overflow: TextOverflow.visible,
        textDirection: textDirection,
        text: TextSpan(
          text: String.fromCharCode(secondaryIconData.codePoint),
          style: secondaryIconStyle,
        ),
      ),
    );


    Widget secondaryStackIconWidget = secondaryIconWidget;
    if (border != null) {
      // Calculate border width as 10% of the icon size
      final borderWidth = iconSize * 0.1;

      secondaryStackIconWidget = Stack(
        alignment: Alignment.center,
        textDirection: textDirection,
        children: [
          RichText(
            overflow: TextOverflow.visible,
            textDirection: textDirection,
            textAlign: TextAlign.center,
            text: TextSpan(
              text: String.fromCharCode(secondaryIconData.codePoint),
              style: secondaryIconStyle.copyWith(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeCap = StrokeCap.square
                  ..strokeJoin = StrokeJoin.miter
                  ..strokeWidth = border.width ?? borderWidth
                  ..color = border.color,
              ),
            ),
          ),
          secondaryIconWidget,
        ],
      );
    }

    double dx = 0.0, dy = 0.0;

    // Adjust the offset to ensure that the secondary icon is bounded by the primary icon's outer edges
    if (alignment == Alignment.bottomCenter || alignment == Alignment.topCenter) {
      dy = alignment!.y * (iconSize / 2) - (alignment!.y * secondaryIconSize / 2);
    } else if (alignment == Alignment.centerLeft || alignment == Alignment.centerRight) {
      dx = alignment!.x * (iconSize / 2) - (alignment!.x * secondaryIconSize / 2);
    } else {
      dx = alignment!.x * (iconSize / 2) - (alignment!.x * secondaryIconSize / 2);
      dy = alignment!.y * (iconSize / 2) - (alignment!.y * secondaryIconSize / 2);
    }

    return Semantics(
      label: icon.semanticLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Stack(
            alignment: Alignment.center, // Base alignment for all items in the stack
            children: [
              iconWidget,
              Transform(
                transform: Matrix4.translationValues(
                  dx,
                  dy,
                  0.0,
                ),
                child: secondaryStackIconWidget,
              )
            ],
          ),
        ),
      ),
    );
  }
}
