import 'package:flutter/material.dart';
import 'package:icon_craft/src/icon_border.dart';

/// {@template icon_decoration}
/// Used to specify a decoration to apply to an [Icon] widget.
///
/// The icon has a [border] and may cast shadows.
///
/// The [border] paints over the icon; the [boxShadow], naturally, paints
/// below it.
/// {@endtemplate}
class IconDecoration {
  /// {@macro icon_decoration}
  const IconDecoration({
    this.border,
  });

  /// A border to draw above the icon color or [gradient].
  final IconBorder? border;
}
