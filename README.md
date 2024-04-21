# IconCraft

![](https://raw.githubusercontent.com/vicenterusso/icon_craft/main/example/assets/banner.png)

IconCraft is a Flutter plugin designed to extend the functionality of the standard `Icon` widget. It allows developers to create richer iconography with the ability to combine two icons into a single widget with alignment and scaling options.

## Features

- **Borders**: Add customizable borders around your icons with configurable colors, widths, and styles.
- **Secondary Icon**: Add an auxiliary icon on top of the base icon, with control over its alignment and relative size, perfect for building creative icon designs.
- **Flexible Alignment**: Precisely position a secondary icon relative to the primary icon, suitable for various UI design needs.

## Installation

To start using IconCraft, add it to your Flutter project by including it in your `pubspec.yaml` file:

```yaml
dependencies:
  icon_craft: ^0.1.0
```

Run `flutter pub get` to install the new dependency.

## Usage
Here's how you can use the IconCraft widget in your Flutter application:

#### Basic Usage

<img src="https://raw.githubusercontent.com/vicenterusso/icon_craft/main/example/assets/icon_01.png" align = "right">

```dart
IconCraft(
  Icon(Icons.email),
  Icon(Icons.notifications),
  alignment: Alignment.topRight,
  decoration: IconDecoration(
    border: IconBorder(color: Colors.white),
  ),
)
```

The border width of the secondary icon automatically adjusts to the basic icon size. However, you can override this by using the width parameter.

```dart
decoration: IconDecoration(
  border: IconBorder(
    color: Colors.white,
    width: 10,
  ),
)
```

#### Colored & Aligned Icons

<img src="https://raw.githubusercontent.com/vicenterusso/icon_craft/main/example/assets/icon_02.png" align = "right">


```dart
IconCraft(
  Icon(
    CupertinoIcons.car_detailed,
    color: Colors.grey.shade500,
  ),
  Icon(
    CupertinoIcons.checkmark_square_fill,
    color: Colors.green.shade200,
  ),
  alignment: Alignment.bottomLeft,
  decoration: IconDecoration(
    border: IconBorder(
      color: Colors.green.shade900,
      width: 8.0,
    ),
  ),
)
```

You can color all the three elements: base icon, secondary icon and the color of the stroke/border effect, and its width


## Screenshots

Here are a few examples demonstrating what you can accomplish with IconCraft:

![](https://raw.githubusercontent.com/vicenterusso/icon_craft/main/example/assets/example01.png)

## Icon packages compatibility:

✅ [Icons Plus](https://pub.dev/packages/icons_plus)

## Credits

This package is inspired by Roux Guillame's work. His original code can be found in this [repository](https://pub.dev/packages/icon_decoration)

## License

Distributed under the BSD 3-Clause License. See LICENSE for more information.