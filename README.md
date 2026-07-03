# 🦘 awesome_jumping_widget

A premium, highly customizable, and lightweight Flutter widget that makes icons, buttons, or any widget jump and shake dynamically. Perfect for drawing user attention to specific interactive areas (such as "Go Pro" crown icons, notification badges, new features, or promotional actions).

![Pub Version](https://img.shields.io/pub/v/awesome_jumping_widget.svg)
![Platform](https://img.shields.io/badge/platform-flutter-blue)
![License](https://img.shields.io/github/license/juanmadelboca/awesome_jumping_widget)

<p align="center">
  <img src="https://raw.githubusercontent.com/juanmadelboca/awesome_jumping_widget/improving_plugin_score/assets/showcase_bar.gif" alt="Awesome Jumping Widget Demo" width="90%"/>
</p>

---

## ✨ Features

- **Any Widget Support:** Animate icons, custom images, text, or complex widget trees.
- **Parametrizable Physics:** Customize jump height, curves (jump up curve vs landing curve), and cycle durations.
- **Playful Wobble/Shake:** Optional rotational shake (wobble) effect during the jump with customized angles.
- **Synchronized Label Support:** Built-in animated text/label display below the jumping element, supporting custom style, text translation, scaling, and color transitions.
- **Controlled Loops:** Set animation execution cycle durations and idle interval periods to keep the interface feeling premium without overwhelming the user.
- **Trigger Control:** Enable/disable animation dynamically using the `shouldAnimate` flag.

---

## 📦 Installation

Add `awesome_jumping_widget` to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  awesome_jumping_widget: ^1.0.0
```

Run:
```bash
flutter pub get
```

---

## 🧪 Usage

### 1️⃣ Simple Usage (Standard Premium Crown Tab)

Perfect for drawing attention to a premium tab or specific action (like "Go Pro" in a bottom navigation bar) using the default settings:

```dart
AwesomeJumpingWidget(
  labelText: 'Go Pro',
  child: Icon(Icons.workspace_premium, color: Colors.amber),
)
```

---

### 2️⃣ Custom Labels and Custom Styles

You can customize the text style, start/end color transition, or provide a fully custom widget as a label instead of a text string:

```dart
AwesomeJumpingWidget(
  labelText: 'New Feature!',
  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  labelColorBegin: Colors.blue,
  labelColorEnd: Colors.purple,
  child: Icon(Icons.star, color: Colors.amber),
)
```

If you need complete control over the layout of the label:

```dart
AwesomeJumpingWidget(
  label: Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text('SALE', style: TextStyle(color: Colors.white, fontSize: 10)),
  ),
  child: const Icon(Icons.shopping_bag),
)
```

---

### 3️⃣ Advanced Configuration: Full Control Over Jump & Wobble Effects

For situations where you want high-intensity jumps, faster animations, or unique bounce curves:

```dart
AwesomeJumpingWidget(
  width: 48,
  height: 48,
  jumpHeight: 20.0,
  animationDuration: const Duration(milliseconds: 1000),
  intervalDuration: const Duration(seconds: 5),
  jumpCurve: Curves.easeOutCubic,
  landCurve: Curves.bounceOut,
  enableShake: true,
  shakeAngle: 0.25,
  labelText: 'Tap Me!',
  labelTop: 52.0,
  child: CircleAvatar(
    backgroundColor: Colors.purpleAccent,
    child: Icon(Icons.star, color: Colors.white, size: 28),
  ),
)
```

---

## ⚙️ Parameters

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *Required* | The widget to animate (jump & shake). |
| `label` | `Widget?` | `null` | A custom widget to display below the jumping element. If set, `labelText` is ignored. |
| `labelText` | `String?` | `null` | Helper string to create a standard `Text` label. |
| `labelStyle` | `TextStyle?` | `null` | TextStyle applied to the `labelText`. |
| `shouldAnimate` | `bool` | `true` | Controls whether the jumping animation loop is active. |
| `animationDuration`| `Duration` | `1500 ms` | The duration of one complete jump/shake cycle. |
| `intervalDuration` | `Duration` | `15 seconds`| Idle interval duration between animation loops. |
| `jumpHeight` | `double` | `10.0` | Peak height of the jump animation (in logical pixels). |
| `jumpCurve` | `Curve` | `Curves.easeOut` | Animation curve used when moving upward. |
| `landCurve` | `Curve` | `Curves.bounceOut` | Animation curve used when landing back down. |
| `enableShake` | `bool` | `true` | Whether the child rotates/shakes during the jump. |
| `shakeAngle` | `double` | `0.15` | Maximum angle (in radians) of rotation/shake. |
| `animateLabel` | `bool` | `true` | Whether to apply scale, translation, and color transition animations to the label. |
| `labelMaxScale` | `double` | `1.1` | Maximum scale factor applied to the label at the peak of the jump. |
| `labelTranslateY` | `double` | `-3.0` | Vertical offset applied to the label during peak jump. |
| `labelColorBegin` | `Color?` | `null` | Initial text/label color. Defaults to text style color or `ThemeData.disabledColor`. |
| `labelColorEnd` | `Color?` | `Colors.orange`| Destination text color at the peak of the jump. |
| `width` | `double` | `24.0` | Bounding box width of the widget container. |
| `height` | `double` | `24.0` | Bounding box height of the widget container. |
| `labelTop` | `double` | `27.0` | Top position of the label relative to the container. |
| `labelHorizontalPadding`| `double`| `-60.0` | Left/right offsets for positioned label to allow overflow. |

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
