# Awesome Jumping Widget 🦘✨

A premium, highly customizable, and lightweight Flutter widget that makes icons, buttons, or any widget jump and shake dynamically. Perfect for drawing user attention to specific interactive areas (such as "Go Pro" crown icons, notification badges, new features, or promotional actions).

## Features

- **Any Widget Support:** Animate icons, custom images, text, or complex widget trees.
- **Parametrizable Physics:** Customize jump height, curves (jump up curve vs landing curve), and cycle durations.
- **Playful Wobble/Shake:** Optional rotational shake (wobble) effect during the jump with customized angles.
- **Synchronized Label Support:** Built-in animated text/label display below the jumping element, supporting custom style, text translation, scaling, and color transitions.
- **Controlled Loops:** Set animation execution cycle durations and idle interval periods to keep the interface feeling premium without overwhelming the user.
- **Trigger Control:** Enable/disable animation dynamically using `shouldAnimate` flag.

---

## Getting started

Add `awesome_jumping_widget` to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  awesome_jumping_widget:
    git:
      url: https://github.com/juanmadelboca/awesome_jumping_widget.git
```

Or once published to pub.dev:

```yaml
dependencies:
  awesome_jumping_widget: ^1.0.0
```

Import it in your Dart code:

```dart
import 'package:awesome_jumping_widget/awesome_jumping_widget.dart';
```

---

## Usage

### Simple Usage (Like a standard Premium Crown Icon in Bottom Nav Bar)

```dart
AwesomeJumpingWidget(
  child: Icon(Icons.crown, color: Colors.orange),
  labelText: 'Go Pro',
)
```

### Advanced Customization

Create a larger, faster jumping widget with customized bounce physics and color transitions:

```dart
AwesomeJumpingWidget(
  width: 48,
  height: 48,
  jumpHeight: 20.0,
  animationDuration: Duration(milliseconds: 1000),
  intervalDuration: Duration(seconds: 5),
  jumpCurve: Curves.easeOutCubic,
  landCurve: Curves.bounceOut,
  enableShake: true,
  shakeAngle: 0.25,
  labelText: 'New Feature!',
  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  labelColorBegin: Colors.blue,
  labelColorEnd: Colors.purple,
  labelTop: 52.0,
  child: CircleAvatar(
    backgroundColor: Colors.purpleAccent,
    child: Icon(Icons.star, color: Colors.white, size: 28),
  ),
)
```

---

## Customizable Parameters

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *Required* | The widget to animate (jump & shake). |
| `label` | `Widget?` | `null` | A custom widget to display below the jumping element. |
| `labelText` | `String?` | `null` | Helper string to create a standard `Text` label (ignored if `label` is set). |
| `labelStyle` | `TextStyle?` | `null` | TextStyle applied to the `labelText`. |
| `shouldAnimate` | `bool` | `true` | Controls whether the jumping cycle is active. |
| `animationDuration`| `Duration` | `1500 ms` | The duration of one complete jump/shake cycle. |
| `intervalDuration` | `Duration` | `15 seconds`| Idle interval between animation loops. |
| `jumpHeight` | `double` | `10.0` | Peak height of the jump animation. |
| `jumpCurve` | `Curve` | `Curves.easeOut` | Curve used when moving upward. |
| `landCurve` | `Curve` | `Curves.bounceOut` | Curve used when landing back down. |
| `enableShake` | `bool` | `true` | Whether the child rotates/shakes during the jump. |
| `shakeAngle` | `double` | `0.15` | Maximum angle (in radians) of rotation/shake. |
| `animateLabel` | `bool` | `true` | Whether to scale, translate, and interpolate label colors. |
| `labelMaxScale` | `double` | `1.1` | Maximum scale factor for the label. |
| `labelTranslateY` | `double` | `-3.0` | Vertical translation applied to the label during peak jump. |
| `labelColorBegin` | `Color?` | `null` | Initial text/label color. Defaults to theme style or disabledColor. |
| `labelColorEnd` | `Color?` | `Colors.orange`| Destination text color at the peak of the jump. |
| `width` | `double` | `24.0` | Base bounding box width. |
| `height` | `double` | `24.0` | Base bounding box height. |
| `labelTop` | `double` | `27.0` | Top position of the label relative to the container. |
| `labelHorizontalPadding`| `double`| `-60.0` | Stack position left/right offsets for wide labels. |

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
