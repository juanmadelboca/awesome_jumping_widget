import 'package:flutter/material.dart';
import 'package:awesome_jumping_widget/awesome_jumping_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Jumping Widget Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatefulWidget {
  const DemoHome({super.key});

  @override
  State<DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  int _currentTab = 0;

  // Playground controller variables
  double _jumpHeight = 12.0;
  double _durationMs = 1200.0;
  double _intervalSeconds = 5.0;
  double _shakeAngle = 0.18;
  bool _enableShake = true;
  bool _shouldAnimate = true;
  bool _animateLabel = true;
  final double _labelMaxScale = 1.15;
  final double _labelTranslateY = -4.0;
  final Color _labelColorBegin = Colors.grey;
  final Color _labelColorEnd = Colors.orangeAccent;

  Curve _jumpCurve = Curves.easeOutCubic;
  Curve _landCurve = Curves.bounceOut;

  final Map<String, Curve> _curves = {
    'easeOut': Curves.easeOut,
    'easeOutCubic': Curves.easeOutCubic,
    'easeOutBack': Curves.easeOutBack,
    'bounceOut': Curves.bounceOut,
    'linear': Curves.linear,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🦘 Awesome Jumping Widget'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildIntroductionCard(),
            const SizedBox(height: 24),
            _buildShowcaseSection(),
            const SizedBox(height: 24),
            _buildPlaygroundSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: AwesomeJumpingWidget(
              jumpHeight: 8.0,
              animationDuration: const Duration(milliseconds: 1400),
              intervalDuration: const Duration(seconds: 10),
              labelColorBegin: Colors.grey,
              labelColorEnd: Colors.amber,
              labelText: 'Go Pro',
              child: const Icon(Icons.workspace_premium, color: Colors.amber),
            ),
            label: '', // Space handled inside custom widget
          ),
        ],
      ),
    );
  }

  Widget _buildIntroductionCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              // ignore: deprecated_member_use
              Colors.deepPurple.shade900.withOpacity(0.8),
              Colors.black54,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Premium Bouncing & Wobbling Effects',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Draw attention to premium options, purchase targets, or critical onboarding flows with fully customizable curves, text scale animations, and intervals.',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowcaseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Interactive Presets',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Preset 1: GoPro Crown Icon
            _buildPresetCard(
              title: 'GoPro Premium',
              subtitle: 'Smooth & Elegant',
              widget: const AwesomeJumpingWidget(
                width: 24,
                height: 24,
                jumpHeight: 10.0,
                animationDuration: Duration(milliseconds: 1500),
                intervalDuration: Duration(seconds: 4),
                labelText: 'Crown Tab',
                child: Icon(Icons.workspace_premium, color: Colors.amber, size: 24),
              ),
            ),
            // Preset 2: Notification Badge
            _buildPresetCard(
              title: 'Alert Badge',
              subtitle: 'Fast High-Jump',
              widget: const AwesomeJumpingWidget(
                width: 32,
                height: 32,
                jumpHeight: 18.0,
                animationDuration: Duration(milliseconds: 800),
                intervalDuration: Duration(seconds: 3),
                labelText: 'Tap Me!',
                labelColorEnd: Colors.redAccent,
                child: Badge(
                  label: Text('5'),
                  child: Icon(Icons.notifications_active, color: Colors.redAccent, size: 32),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPresetCard({required String title, required String subtitle, required Widget widget}) {
    return Card(
      elevation: 2,
      child: Container(
        width: 160,
        height: 140,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(child: widget),
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaygroundSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Icon(Icons.tune, color: Colors.deepPurpleAccent),
                SizedBox(width: 8),
                Text(
                  'Live Parameter Playground',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Playground Widget Preview Box
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: Center(
                child: AwesomeJumpingWidget(
                  width: 48,
                  height: 48,
                  shouldAnimate: _shouldAnimate,
                  jumpHeight: _jumpHeight,
                  animationDuration: Duration(milliseconds: _durationMs.toInt()),
                  intervalDuration: Duration(seconds: _intervalSeconds.toInt()),
                  jumpCurve: _jumpCurve,
                  landCurve: _landCurve,
                  enableShake: _enableShake,
                  shakeAngle: _shakeAngle,
                  animateLabel: _animateLabel,
                  labelMaxScale: _labelMaxScale,
                  labelTranslateY: _labelTranslateY,
                  labelColorBegin: _labelColorBegin,
                  labelColorEnd: _labelColorEnd,
                  labelText: 'Custom Item',
                  labelTop: 54,
                  labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.deepPurple.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.star, color: Colors.amber, size: 28),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Controls
            Row(
              children: [
                Expanded(
                  child: _buildSwitchTile(
                    title: 'Loop Active',
                    value: _shouldAnimate,
                    onChanged: (val) => setState(() => _shouldAnimate = val),
                  ),
                ),
                Expanded(
                  child: _buildSwitchTile(
                    title: 'Rotate Shake',
                    value: _enableShake,
                    onChanged: (val) => setState(() => _enableShake = val),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildSwitchTile(
                    title: 'Animate Label',
                    value: _animateLabel,
                    onChanged: (val) => setState(() => _animateLabel = val),
                  ),
                ),
              ],
            ),

            const Divider(height: 24, color: Colors.white10),

            _buildSliderRow(
              label: 'Jump Height (px)',
              value: _jumpHeight,
              min: 0.0,
              max: 30.0,
              divisions: 30,
              onChanged: (val) => setState(() => _jumpHeight = val),
            ),
            _buildSliderRow(
              label: 'Animation Speed (ms)',
              value: _durationMs,
              min: 400.0,
              max: 3000.0,
              divisions: 26,
              onChanged: (val) => setState(() => _durationMs = val),
            ),
            _buildSliderRow(
              label: 'Loop Interval (sec)',
              value: _intervalSeconds,
              min: 1.0,
              max: 20.0,
              divisions: 19,
              onChanged: (val) => setState(() => _intervalSeconds = val),
            ),
            _buildSliderRow(
              label: 'Shake Angle (rad)',
              value: _shakeAngle,
              min: 0.0,
              max: 0.8,
              divisions: 16,
              onChanged: (val) => setState(() => _shakeAngle = val),
            ),

            const Divider(height: 24, color: Colors.white10),

            // Curve selectors
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    label: 'Jump Up Curve',
                    value: _jumpCurve,
                    onChanged: (val) => setState(() => _jumpCurve = val!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown(
                    label: 'Landing Curve',
                    value: _landCurve,
                    onChanged: (val) => setState(() => _landCurve = val!),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      dense: true,
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(
              value.toStringAsFixed(1),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
          activeColor: Colors.deepPurpleAccent,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required Curve value,
    required ValueChanged<Curve?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        DropdownButton<Curve>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          items: _curves.entries.map((entry) {
            return DropdownMenuItem<Curve>(
              value: entry.value,
              child: Text(entry.key, style: const TextStyle(fontSize: 13)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
