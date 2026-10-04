import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// ================= EDIT YOUR DETAILS =================
const fullName = 'NAYAN THAKARE';
const onlineName = 'Dynamo';
const role = 'Computer Engineering Student · App Developer';
const email = 'thakarenayan2812@gmail.com';
const github = 'https://github.com/thakarenayan2812-sys';
const linkedin = 'https://www.linkedin.com/in/nayan-thakare-395663369/';
// Avatar traits: change so the avatar looks like you
const skin = Color(0xFFE0A878);
const hairColor = ink;
const wearsGlasses = false;

const bioParagraphs = [
  'I\'m Nayan Thakare (Dynamo online), a computer engineering student at VIT Pune. I\'m a good software student because I learn by building: every project here pushed me into something new, from sensor data on an ESP32 to emotion recognition in Flask to Flutter apps with real astronomy maths behind them.',
  'My maths background (calculus, differential equations, vector calculus) means I understand the logic behind an algorithm, not just the syntax. Add Python, C, Dart and Flutter, and I can take an idea from a rough sketch to a working, animated app.',
  'How I can help: if you need a mobile app, an IoT prototype or an AI-assisted tool, I can design it, build it, debug it patiently and keep you clearly updated at every step.',
];

const whyMe = [
  ('STRONG FOUNDATIONS', 'Calculus, differential equations and vector calculus, plus Python and C, give me a solid base for algorithms and for modelling real-world problems.'),
  ('HARDWARE TO UI', 'I have built an ESP32 telescope finder, a Flask computer-vision web app and Flutter apps, so I can take an idea from sensor or model all the way to a finished screen.'),
  ('I LEARN BY SHIPPING', 'New tool, new problem, new bug: I dig in, debug patiently and work well solo or in teams of three and four.'),
];

const skills = [
  ('MOBILE', ['Flutter', 'Dart', 'Material UI', 'Bluetooth LE', 'Animations']),
  ('LANGUAGES', ['Dart', 'Python', 'C']),
  ('HARDWARE & IOT', ['ESP32', 'MPU6050', 'Magnetometer', 'Sensors']),
  ('WEB & AI', ['Flask', 'FER emotion detection', 'Spotify API', 'OAuth 2.0']),
  ('MATHEMATICS', ['Calculus', 'Differential equations', 'Vector calculus', 'Infinite series']),
];

class Project {
  final String title, tag, status, who, summary, overview;
  final bool done;
  final List<String> features, stack;
  final String? url;
  const Project(this.title, this.tag, this.status, this.who, this.done, this.summary, this.overview, this.features, this.stack, this.url);
}

const projects = [
  Project('PersonnelCare', 'Welfare monitoring for armed forces personnel', 'IN DEVELOPMENT', 'Solo developer', false,
      'AI-powered stress and welfare monitoring for CAPF and armed forces personnel.',
      'PersonnelCare predicts burnout risk by combining HR signals with personnel self-reports, then guides welfare officers towards the right intervention. It is in active development and I am the only developer working on it.',
      [
        'Flutter mobile app for personnel self-assessment',
        'Burnout risk prediction from HR signals and self-reports',
        'Rule-based intervention and recommendation layer',
        'Case-status tracking for welfare officers',
        'Therapist and counsellor referral flow, mediated by the welfare officer',
        'Role-training mismatch flagged as a stress factor',
      ],
      ['Flutter', 'Dart', 'AI risk prediction'], 'https://personnelcaremeow.netlify.app/'),
  Project('SkyPointer', 'Smart telescope finder', 'BUILT', 'Personal project', true,
      'ESP32 hardware and a Flutter app that guide you to objects in the night sky.',
      'An ESP32 with an MPU6050 and a magnetometer senses where the telescope is pointing, and the Flutter app turns that into live Alt/Az guidance for finding objects in the sky.',
      [
        'Real astronomical Alt/Az calculations',
        'Bluetooth LE link between phone and ESP32',
        'Dark sky mapping',
        'Observation logging',
        'Ten visual themes',
      ],
      ['ESP32', 'MPU6050', 'Magnetometer', 'Flutter', 'Bluetooth LE'], null),
  Project('Surat aur Sur', 'Emotion-based music player', 'BUILT', 'Personal project', true,
      'A web app that reads your face and plays music to match your mood.',
      'Surat aur Sur detects your emotion from your face and plays music that suits it. It is a Flask web app built around facial emotion recognition.',
      [
        'Facial emotion detection with FER',
        'Plays music from local folders',
        'Spotify API playback (OAuth 2.0, Premium account)',
        'Flask web interface',
      ],
      ['Python', 'Flask', 'FER', 'Spotify API', 'OAuth 2.0'], null),
  Project('HobbyHub AI', 'Rediscover your hobbies', 'IN PROGRESS', 'Team of four', false,
      'A mobile platform that helps people rediscover hobbies and stick with them.',
      'HobbyHub AI helps people return to hobbies they have drifted away from and keep going. It is a semester project built with a team of four.',
      [
        'Photo-verified streaks: a streak counts only with a new photo of you doing the activity',
        'On-device LLM, no external AI API calls',
        'Optional digital wellbeing data to spot time leaks, only with permission',
        'Separate tabs for each feature area',
      ],
      ['Flutter', 'On-device LLM', 'Mobile'], 'https://hobbyhubai.netlify.app/'),
];
// =====================================================

// Bauhaus tokens
const bg = Color(0xFFF0F0F0), ink = Color(0xFF121212);
const red = Color(0xFFD02020), blue = Color(0xFF1040C0), yellow = Color(0xFFF0C020);
const pc = [red, blue, yellow];
const pfg = [Colors.white, Colors.white, ink];

TextStyle t(double s, {FontWeight w = FontWeight.w900, Color c = ink, double ls = -1, double h = 1}) =>
    GoogleFonts.outfit(fontSize: s, fontWeight: w, color: c, letterSpacing: ls, height: h);

BoxDecoration box(Color c, {double b = 4, double s = 8, bool circle = false}) => BoxDecoration(
    color: c,
    shape: circle ? BoxShape.circle : BoxShape.rectangle,
    border: Border.all(color: ink, width: b),
    boxShadow: s > 0 ? [BoxShadow(color: ink, offset: Offset(s, s), blurRadius: 0)] : []);

Widget gap(double h) => SizedBox(height: h);

Future<void> openUri(BuildContext ctx, Uri u) async {
  var ok = false;
  try { ok = await launchUrl(u, mode: LaunchMode.externalApplication); } catch (_) {}
  if (!ok && ctx.mounted) {
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('Could not open that on this device.')));
  }
}

Uri mailUri({String subject = 'Hello from your portfolio', String body = ''}) => Uri.parse(
    'mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}');

void main() => runApp(MaterialApp(
  title: 'Nayan Thakare',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: bg,
    colorScheme: ColorScheme.fromSeed(seedColor: blue, primary: red, surface: bg),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: ink, behavior: SnackBarBehavior.floating, contentTextStyle: t(14, w: FontWeight.w700, c: Colors.white, ls: 0)),
  ),
  home: const Shell(),
));

// ---------- painters & small widgets ----------

class _Tri extends CustomPainter {
  final Color c;
  _Tri(this.c);
  @override
  void paint(Canvas cv, Size s) {
    final p = Path()..moveTo(s.width / 2, 2)..lineTo(2, s.height - 2)..lineTo(s.width - 2, s.height - 2)..close();
    cv.drawPath(p, Paint()..color = c);
    cv.drawPath(p, Paint()..color = ink..style = PaintingStyle.stroke..strokeWidth = 3);
  }
  @override
  bool shouldRepaint(_Tri o) => o.c != c;
}

class _Dots extends CustomPainter {
  @override
  void paint(Canvas cv, Size s) {
    final p = Paint()..color = Colors.white24;
    for (double x = 10; x < s.width; x += 20) { for (double y = 10; y < s.height; y += 20) { cv.drawCircle(Offset(x, y), 2, p); } }
  }
  @override
  bool shouldRepaint(_) => false;
}

class Geo extends StatelessWidget {
  const Geo(this.k, this.s, this.c, {super.key});
  final int k;
  final double s;
  final Color c;
  @override
  Widget build(BuildContext context) => k == 2
      ? CustomPaint(size: Size(s, s), painter: _Tri(c))
      : AnimatedContainer(duration: const Duration(milliseconds: 200), width: s, height: s, decoration: box(c, b: 2, s: 0, circle: k == 0));
}

class Spin extends StatefulWidget {
  const Spin(this.seconds, this.child, {super.key});
  final int seconds;
  final Widget child;
  @override
  State<Spin> createState() => _SpinState();
}

class _SpinState extends State<Spin> with SingleTickerProviderStateMixin {
  late final c = AnimationController(vsync: this, duration: Duration(seconds: widget.seconds))..repeat();
  @override
  void dispose() { c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => RotationTransition(turns: c, child: widget.child);
}

/// Mechanical slide-in. Because ListView builds lazily, sections reveal as you scroll to them.
class Reveal extends StatelessWidget {
  const Reveal(this.child, {super.key, this.delay = 0, this.from = const Offset(0, 1), this.clip = true});
  final Widget child;
  final int delay;
  final Offset from;
  final bool clip;
  @override
  Widget build(BuildContext context) {
    final total = 500 + delay;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: total),
      curve: Interval(delay / total, 1, curve: Curves.easeOutCubic),
      child: child,
      builder: (_, v, c) {
        final w = FractionalTranslation(translation: from * (1 - v), child: c);
        return clip ? ClipRect(child: w) : w;
      },
    );
  }
}

class BButton extends StatefulWidget {
  const BButton(this.label, this.onTap, {super.key, this.color = red, this.fg = Colors.white, this.icon, this.expand = false});
  final String label;
  final VoidCallback onTap;
  final Color color, fg;
  final IconData? icon;
  final bool expand;
  @override
  State<BButton> createState() => _BButtonState();
}

class _BButtonState extends State<BButton> {
  bool d = false;
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: widget.label,
    child: GestureDetector(
      onTapDown: (_) => setState(() => d = true),
      onTapUp: (_) { setState(() => d = false); widget.onTap(); },
      onTapCancel: () => setState(() => d = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(d ? 4 : 0, d ? 4 : 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: box(widget.color, b: 3, s: d ? 0 : 4),
        child: Row(
          mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[Icon(widget.icon, color: widget.fg, size: 20), const SizedBox(width: 8)],
            Flexible(child: Text(widget.label.toUpperCase(), overflow: TextOverflow.ellipsis, style: t(14, w: FontWeight.w700, c: widget.fg, ls: 1.5))),
          ],
        ),
      ),
    ),
  );
}

class Chip2 extends StatelessWidget {
  const Chip2(this.text, {super.key, this.color = bg, this.fg = ink});
  final String text;
  final Color color, fg;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: box(color, b: 2, s: 0),
      child: Text(text.toUpperCase(), style: t(11, w: FontWeight.w700, ls: 1.5, c: fg)));
}

class InfoBox extends StatelessWidget {
  const InfoBox({super.key, required this.child, this.i = 0, this.color = Colors.white});
  final Widget child;
  final int i;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: box(color, s: 6),
    child: Stack(clipBehavior: Clip.none, children: [
      child,
      Positioned(top: -12, right: -12, child: Geo(i % 3, 14, pc[i % 3])),
    ]),
  );
}

/// Section with label, big title and a thick divider (Bauhaus rhythm).
class Sec extends StatelessWidget {
  const Sec(this.label, this.title, {super.key, required this.child, this.color = bg, this.fg = ink});
  final String label, title;
  final Widget child;
  final Color color, fg;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(20, 40, 20, 44),
    decoration: BoxDecoration(color: color, border: const Border(bottom: BorderSide(color: ink, width: 4))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Reveal(Text(label.toUpperCase(), style: t(12, w: FontWeight.w700, ls: 4, c: fg))),
      gap(6),
      Reveal(delay: 80, Text(title.toUpperCase(), style: t(36, c: fg, h: .95))),
      gap(24),
      child,
    ]),
  );
}

class Marquee extends StatefulWidget {
  const Marquee(this.text, this.color, this.fg, {super.key});
  final String text;
  final Color color, fg;
  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {
  final sc = ScrollController();
  late final Ticker tk = createTicker((d) { if (sc.hasClients) sc.jumpTo(d.inMicroseconds / 1e6 * 70); })..start();
  @override
  void initState() { super.initState(); tk; }
  @override
  void dispose() { tk.dispose(); sc.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Container(
    height: 56,
    decoration: BoxDecoration(color: widget.color, border: const Border(bottom: BorderSide(color: ink, width: 4))),
    child: ListView.builder(
      controller: sc,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) => Center(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Text(widget.text, style: t(22, c: widget.fg, ls: 2)))),
    ),
  );
}

class Typewriter extends StatefulWidget {
  const Typewriter(this.prefix, this.words, {super.key});
  final String prefix;
  final List<String> words;
  @override
  State<Typewriter> createState() => _TypewriterState();
}

class _TypewriterState extends State<Typewriter> with SingleTickerProviderStateMixin {
  late final Ticker tk;
  String txt = '';
  bool cur = true;
  @override
  void initState() {
    super.initState();
    tk = createTicker((d) {
      var s = d.inMicroseconds / 1e6;
      final total = widget.words.fold<double>(0, (a, w) => a + w.length / 12 + 1.4 + w.length / 28);
      s %= total;
      var out = '';
      for (final w in widget.words) {
        final tin = w.length / 12, tout = w.length / 28, c = tin + 1.4 + tout;
        if (s < c) {
          final n = s < tin ? (s * 12).floor() : s < tin + 1.4 ? w.length : w.length - ((s - tin - 1.4) * 28).floor();
          out = w.substring(0, n.clamp(0, w.length).toInt());
          break;
        }
        s -= c;
      }
      final cu = (d.inMilliseconds ~/ 500).isEven;
      if (out != txt || cu != cur) setState(() { txt = out; cur = cu; });
    })..start();
  }
  @override
  void dispose() { tk.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Text.rich(TextSpan(style: t(18, w: FontWeight.w500, ls: 0), children: [
    TextSpan(text: widget.prefix),
    TextSpan(text: txt, style: t(18, w: FontWeight.w700, ls: 0, c: red)),
    TextSpan(text: cur ? '|' : ' '),
  ]));
}

class Count extends StatelessWidget {
  const Count(this.n, this.label, {super.key});
  final int n;
  final String label;
  @override
  Widget build(BuildContext context) => Column(children: [
    TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: n.toDouble()),
        duration: const Duration(milliseconds: 1400),
        curve: Curves.easeOutCubic,
        builder: (_, v, __) => Text('${v.round()}', style: t(56, h: 1))),
    Text(label, style: t(11, w: FontWeight.w700, ls: 2)),
  ]);
}

class TopBar extends StatelessWidget {
  const TopBar(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 12, 16, 12),
    decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: ink, width: 4))),
    child: Row(children: [
      const Geo(0, 16, red), const SizedBox(width: 6), const Geo(1, 16, blue), const SizedBox(width: 6), const Geo(2, 16, yellow),
      const SizedBox(width: 14),
      Text(title, style: t(18, ls: 3)),
    ]),
  );
}

/// Top bar + scroll progress line + scrolling content.
class PageShell extends StatefulWidget {
  const PageShell(this.title, this.children, {super.key});
  final String title;
  final List<Widget> children;
  @override
  State<PageShell> createState() => _PageShellState();
}

class _PageShellState extends State<PageShell> {
  final sc = ScrollController();
  @override
  void dispose() { sc.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Column(children: [
    TopBar(widget.title),
    AnimatedBuilder(
      animation: sc,
      builder: (_, __) {
        final p = sc.hasClients && sc.position.maxScrollExtent > 0 ? (sc.offset / sc.position.maxScrollExtent).clamp(0.0, 1.0) : 0.0;
        return SizedBox(height: 6, child: Stack(children: [
          const Positioned.fill(child: ColoredBox(color: Color(0xFFE0E0E0))),
          Align(alignment: Alignment.centerLeft, child: FractionallySizedBox(widthFactor: p, heightFactor: 1, child: const ColoredBox(color: red))),
        ]));
      },
    ),
    Expanded(child: ListView(controller: sc, children: widget.children)),
  ]);
}

// ---------- 3D avatar with changing expressions ----------

class _Face extends CustomPainter {
  final int e;
  final bool blink;
  _Face(this.e, this.blink);
  @override
  void paint(Canvas cv, Size s) {
    final line = Paint()..color = ink..style = PaintingStyle.stroke..strokeWidth = 4..strokeCap = StrokeCap.round;
    final fill = Paint()..color = ink;
    void eye(double x, bool closed) {
      if (closed || blink) {
        cv.drawLine(Offset(x - 7, 64), Offset(x + 7, 64), line);
      } else {
        cv.drawCircle(Offset(x, 64), e == 2 ? 8 : 6, fill);
      }
    }
    eye(43, false);
    eye(75, e == 3);
    final by = e == 2 ? 46.0 : 54.0;
    cv.drawLine(Offset(32, by), Offset(52, by), line);
    cv.drawLine(Offset(66, by - (e == 4 ? 6 : 0)), Offset(86, by - (e == 4 ? 6 : 0)), line);
    final m = Path();
    switch (e) {
      case 1:
        m..moveTo(46, 92)..lineTo(72, 92);
      case 2:
        cv.drawCircle(const Offset(59, 94), 9, Paint()..color = red);
        cv.drawCircle(const Offset(59, 94), 9, line..strokeWidth = 3);
        return;
      case 4:
        m..moveTo(44, 92)..quadraticBezierTo(64, 96, 76, 84);
      default:
        m..moveTo(42, 86)..quadraticBezierTo(59, 106, 76, 86);
    }
    cv.drawPath(m, line..strokeWidth = 4);
  }
  @override
  bool shouldRepaint(_Face o) => o.e != e || o.blink != blink;
}

class Avatar3D extends StatefulWidget {
  const Avatar3D({super.key});
  @override
  State<Avatar3D> createState() => _Avatar3DState();
}

class _Avatar3DState extends State<Avatar3D> with SingleTickerProviderStateMixin {
  late final Ticker tk;
  double _t = 0, _ry = 0;
  bool _drag = false;
  @override
  void initState() {
    super.initState();
    tk = createTicker((d) => setState(() { _t = d.inMicroseconds / 1e6; if (!_drag) _ry *= 0.93; }))..start();
  }
  @override
  void dispose() { tk.dispose(); super.dispose(); }

  Widget layer(double z, double l, double top, Widget c) =>
      Positioned(left: l, top: top, child: Transform(transform: Matrix4.translationValues(0, 0, z), child: c));

  @override
  Widget build(BuildContext context) {
    final ry = _ry + math.sin(_t * 0.9) * 0.3, rx = math.sin(_t * 0.7) * 0.08 - 0.05;
    final expr = (_t / 2.6).floor() % 5, blink = _t % 3.7 < .14;
    final dark = Color.lerp(skin, ink, .18)!;
    final icons = [Icons.explore, Icons.music_note, Icons.code];
    final back = <Widget>[], front = <Widget>[];
    for (var i = 0; i < 3; i++) {
      final a = _t * 0.9 + i * 2 * math.pi / 3, dz = math.sin(a) * 130;
      final chip = layer(dz, 120 + math.cos(a) * 135 - 21, 140 + math.sin(a) * 18 - 21,
          Container(width: 42, height: 42, decoration: box(Colors.white, b: 3, s: 3, circle: i != 1), child: Icon(icons[i], size: 22)));
      (dz < -20 ? back : front).add(chip);
    }
    return Semantics(
      label: 'Interactive 3D avatar. Swipe sideways to rotate.',
      child: SizedBox(
        height: 300,
        child: Center(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragStart: (_) => _drag = true,
            onHorizontalDragUpdate: (d) => _ry = (_ry + d.delta.dx * 0.012).clamp(-math.pi * .9, math.pi * .9),
            onHorizontalDragEnd: (_) => _drag = false,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..setEntry(3, 2, 0.0012)..rotateX(rx)..rotateY(ry),
              child: SizedBox(
                width: 240, height: 280,
                child: Stack(clipBehavior: Clip.none, children: [
                  ...back,
                  layer(-90, 45, 40, Transform.rotate(angle: math.pi / 4 + _t * .4, child: Container(width: 150, height: 150, decoration: box(red, b: 4, s: 0)))),
                  layer(-50, 25, 20, Container(width: 190, height: 190, decoration: box(yellow, b: 4, s: 0, circle: true))),
                  layer(0, 25, 190, Container(width: 190, height: 90,
                      decoration: BoxDecoration(color: blue, border: Border.all(color: ink, width: 4), borderRadius: const BorderRadius.vertical(top: Radius.circular(95))))),
                  layer(12, 102, 150, Container(width: 36, height: 50, decoration: box(dark, b: 3, s: 0))),
                  layer(35, 61, 62, Container(width: 118, height: 118, decoration: box(skin, b: 4, s: 0, circle: true))),
                  layer(48, 61, 55, Container(width: 118, height: 56,
                      decoration: BoxDecoration(color: hairColor, border: Border.all(color: ink, width: 4), borderRadius: const BorderRadius.vertical(top: Radius.circular(59))))),
                  layer(55, 61, 62, CustomPaint(size: const Size(118, 118), painter: _Face(expr, blink))),
                  if (wearsGlasses) ...[
                    layer(58, 87, 109, Container(width: 34, height: 34, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ink, width: 3)))),
                    layer(58, 119, 109, Container(width: 34, height: 34, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ink, width: 3)))),
                  ],
                  layer(95, 8, 215, CustomPaint(size: const Size(46, 46), painter: _Tri(red))),
                  ...front,
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.onContact});
  final VoidCallback onContact;
  @override
  Widget build(BuildContext context) => Container(
    decoration: box(Colors.white),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(children: [
        Container(
          decoration: const BoxDecoration(color: blue, border: Border(bottom: BorderSide(color: ink, width: 4))),
          child: ClipRect(child: Stack(children: [Positioned.fill(child: CustomPaint(painter: _Dots())), const Center(child: Avatar3D())])),
        ),
        const Positioned(top: 12, right: 12, child: Spin(8, Geo(1, 16, yellow))),
        Positioned(left: 12, bottom: 10, child: Text('SWIPE TO ROTATE', style: t(10, w: FontWeight.w700, ls: 2, c: Colors.white70))),
      ]),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(fullName, style: t(30, h: .95)),
          gap(4),
          Text('aka $onlineName', style: t(16, w: FontWeight.w700, ls: 0, c: red)),
          gap(8),
          Text(role.toUpperCase(), style: t(11, w: FontWeight.w700, ls: 1.8)),
          gap(18),
          BButton('Contact me', onContact, icon: Icons.mail_outline),
        ]),
      ),
    ]),
  );
}

// ---------- Home ----------

class Home extends StatelessWidget {
  const Home({super.key, required this.go});
  final void Function(int) go;
  @override
  Widget build(BuildContext context) => PageShell('HOME', [
    Stack(children: [
      Positioned(right: -60, top: 40, child: Spin(30, Transform.rotate(angle: math.pi / 4, child: Container(width: 170, height: 170, decoration: box(yellow, b: 4, s: 0))))),
      Positioned(right: 36, top: 210, child: Container(width: 60, height: 60, decoration: box(blue, b: 4, s: 0, circle: true))),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Reveal(const Chip2('Computer engineering · VIT Pune', color: Colors.white)),
          gap(18),
          Reveal(delay: 80, Text('THINK.', style: t(62, h: .9))),
          Reveal(delay: 180, Text('CODE.', style: t(62, c: red, h: .9))),
          Reveal(delay: 280, Text('SHIP.', style: t(62, c: blue, h: .9))),
          gap(20),
          Reveal(delay: 420, Text('Hi, I\'m Nayan Thakare, aka $onlineName.', style: t(18, w: FontWeight.w700, ls: 0))),
          gap(6),
          Reveal(delay: 520, const Typewriter('I make ', ['Flutter apps', 'ESP32 gadgets', 'AI-powered tools', 'smooth, animated UIs'])),
        ]),
      ),
    ]),
    Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 28, 44),
      child: Reveal(delay: 300, from: const Offset(0, .25), clip: false, ProfileCard(onContact: () => openUri(context, mailUri()))),
    ),
    Container(
      color: yellow,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 12),
      decoration: null,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Count(4, 'PROJECTS'),
        Container(width: 4, height: 60, color: ink),
        const Count(3, 'LANGUAGES'),
        Container(width: 4, height: 60, color: ink),
        const Count(3, 'PLATFORMS'),
      ]),
    ),
    const Marquee('FLUTTER ● DART ● PYTHON ● C ● ESP32 ● FLASK ● ', Colors.black, Colors.white),
    Sec('02 — Why me', 'What I bring',
        child: Column(children: [
          for (var i = 0; i < whyMe.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 24, right: 8),
              child: Reveal(delay: i * 100, from: Offset(i.isEven ? -1.2 : 1.2, 0), clip: false,
                  InfoBox(i: i, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('0${i + 1}', style: t(14, w: FontWeight.w700, ls: 3, c: i == 2 ? ink : pc[i])),
                    gap(6),
                    Text(whyMe[i].$1, style: t(22, h: 1)),
                    gap(10),
                    Text(whyMe[i].$2, style: t(15, w: FontWeight.w500, ls: 0, h: 1.5)),
                  ]))),
            ),
        ])),
    Sec('03 — About', 'Why I\'m a good software student', color: blue, fg: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (var i = 0; i < bioParagraphs.length; i++)
            Reveal(delay: i * 120, Padding(padding: const EdgeInsets.only(bottom: 16), child: Text(bioParagraphs[i], style: t(16, w: FontWeight.w500, ls: 0, h: 1.6, c: Colors.white)))),
        ])),
    Sec('04 — Skills', 'Toolbox',
        child: Column(children: [
          for (var i = 0; i < skills.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 22, right: 8),
              child: Reveal(delay: 60, from: Offset(i.isEven ? -1.2 : 1.2, 0), clip: false,
                  InfoBox(i: i, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(skills[i].$1, style: t(14, ls: 3)),
                    gap(12),
                    Wrap(spacing: 8, runSpacing: 8, children: [for (final s in skills[i].$2) Chip2(s)]),
                  ]))),
            ),
        ])),
    Sec('05 — Now building', projects[0].title, color: red, fg: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Reveal(Text(projects[0].overview, style: t(16, w: FontWeight.w500, ls: 0, h: 1.6, c: Colors.white))),
          gap(20),
          Reveal(delay: 100, const Wrap(spacing: 8, runSpacing: 8, children: [Chip2('In development', color: yellow), Chip2('Solo developer', color: Colors.white)])),
          gap(24),
          BButton('See all projects', () => go(1), color: Colors.white, fg: ink, icon: Icons.arrow_forward),
        ])),
    Container(
      width: double.infinity,
      color: ink,
      padding: const EdgeInsets.fromLTRB(20, 44, 20, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Reveal(Text('LET\'S WORK\nTOGETHER.', style: t(40, c: Colors.white, h: .95))),
        gap(14),
        Text('Have an app, IoT or AI idea? Let\'s talk.', style: t(16, w: FontWeight.w500, ls: 0, c: Colors.white70)),
        gap(22),
        BButton('Get in touch', () => go(2), color: yellow, fg: ink, icon: Icons.mail_outline),
        gap(40),
        Text('© 2026 $fullName · BUILT WITH FLUTTER', style: t(10, w: FontWeight.w700, ls: 2, c: Colors.white54)),
      ]),
    ),
  ]);
}

// ---------- Projects ----------

class _CircleClip extends CustomClipper<Path> {
  final Offset o;
  final double p;
  _CircleClip(this.o, this.p);
  @override
  Path getClip(Size s) => Path()..addOval(Rect.fromCircle(center: o, radius: math.sqrt(s.width * s.width + s.height * s.height) * p));
  @override
  bool shouldReclip(_CircleClip old) => old.p != p;
}

Route circleRoute(Widget page, Offset o) => PageRouteBuilder(
  transitionDuration: const Duration(milliseconds: 600),
  reverseTransitionDuration: const Duration(milliseconds: 400),
  pageBuilder: (_, __, ___) => page,
  transitionsBuilder: (_, a, __, child) => ClipPath(clipper: _CircleClip(o, Curves.easeOut.transform(a.value)), child: child),
);

class Projects extends StatefulWidget {
  const Projects({super.key});
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  int f = 0;
  Widget filter(int i, String label) => GestureDetector(
    onTap: () => setState(() => f = i),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: box(f == i ? ink : Colors.white, b: 3, s: f == i ? 0 : 3),
      child: Text(label, style: t(12, w: FontWeight.w700, ls: 2, c: f == i ? Colors.white : ink)),
    ),
  );
  @override
  Widget build(BuildContext context) => PageShell('PROJECTS', [
    Sec('02 — Selected work', 'Projects',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Reveal(Text('Four builds across mobile, web and embedded hardware. Tap a card for the full story.', style: t(16, w: FontWeight.w500, ls: 0, h: 1.5))),
          gap(20),
          Wrap(spacing: 10, runSpacing: 10, children: [filter(0, 'ALL'), filter(1, 'BUILT'), filter(2, 'IN PROGRESS')]),
          gap(28),
          for (var i = 0; i < projects.length; i++)
            if (f == 0 || (f == 1) == projects[i].done)
              Padding(
                padding: const EdgeInsets.only(bottom: 28, right: 8),
                child: KeyedSubtree(
                  key: ValueKey('$f-$i'),
                  child: Reveal(delay: 40, from: Offset(i.isEven ? -1.3 : 1.3, 0), clip: false, _PCard(i)),
                ),
              ),
        ])),
    Sec('More', 'See the code', color: yellow,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Reveal(Text('More of my work, experiments and commits live on GitHub.', style: t(16, w: FontWeight.w500, ls: 0, h: 1.5))),
          gap(20),
          BButton('Open GitHub', () => openUri(context, Uri.parse(github)), color: ink, icon: Icons.code),
        ])),
  ]);
}

class _PCard extends StatefulWidget {
  const _PCard(this.i);
  final int i;
  @override
  State<_PCard> createState() => _PCardState();
}

class _PCardState extends State<_PCard> {
  bool d = false;
  @override
  Widget build(BuildContext context) {
    final p = projects[widget.i], c = pc[widget.i % 3];
    return GestureDetector(
      onTapDown: (_) => setState(() => d = true),
      onTapCancel: () => setState(() => d = false),
      onTapUp: (x) {
        setState(() => d = false);
        Navigator.of(context).push(circleRoute(Detail(widget.i), x.globalPosition));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(d ? 6 : 0, d ? 6 : 0, 0),
        decoration: box(Colors.white, s: d ? 2 : 8),
        padding: const EdgeInsets.all(20),
        child: Stack(children: [
          Positioned(top: 0, right: 0, child: Geo(widget.i % 3, 18, c)),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('0${widget.i + 1}', style: t(14, w: FontWeight.w700, ls: 3, c: c == yellow ? ink : c)),
            gap(6),
            Padding(padding: const EdgeInsets.only(right: 28), child: Text(p.title.toUpperCase(), style: t(30, h: .95))),
            gap(4),
            Text(p.tag, style: t(14, w: FontWeight.w700, ls: 0, c: Colors.black54)),
            gap(10),
            Text(p.summary, style: t(15, w: FontWeight.w500, ls: 0, h: 1.45)),
            gap(14),
            Wrap(spacing: 8, runSpacing: 8, children: [
              Chip2(p.status, color: p.done ? blue : yellow, fg: p.done ? Colors.white : ink),
              Chip2(p.who),
            ]),
            gap(14),
            Row(children: [
              Text('VIEW DETAILS', style: t(12, w: FontWeight.w700, ls: 2)),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward, size: 16),
            ]),
          ]),
        ]),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail(this.i, {super.key});
  final int i;
  @override
  Widget build(BuildContext context) {
    final p = projects[i], c = pc[i % 3], fg = pfg[i % 3];
    return Scaffold(
      backgroundColor: c,
      body: PageShell('PROJECT 0${i + 1}', [
        Stack(children: [
          Positioned(right: -50, top: 30, child: Spin(26, Transform.rotate(angle: math.pi / 4, child: Container(width: 160, height: 160, decoration: box(Colors.white24, b: 4, s: 0))))),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Reveal(Wrap(spacing: 8, runSpacing: 8, children: [
                Chip2(p.status, color: Colors.white),
                Chip2(p.who, color: Colors.white),
              ])),
              gap(16),
              Reveal(delay: 80, Text(p.title.toUpperCase(), style: t(52, c: fg, h: .92))),
              gap(10),
              Reveal(delay: 160, Text(p.tag, style: t(18, w: FontWeight.w700, ls: 0, c: fg))),
            ]),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 28, 28),
          child: Reveal(delay: 100, from: const Offset(0, .3), clip: false,
              InfoBox(i: i, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('OVERVIEW', style: t(12, w: FontWeight.w700, ls: 3)),
                gap(10),
                Text(p.overview, style: t(16, w: FontWeight.w500, ls: 0, h: 1.55)),
              ]))),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 28, 28),
          child: InfoBox(i: i + 1, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('WHAT IT DOES', style: t(12, w: FontWeight.w700, ls: 3)),
            gap(14),
            for (var k = 0; k < p.features.length; k++)
              Reveal(delay: k * 90, from: const Offset(-1.2, 0), Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(width: 26, height: 26, alignment: Alignment.center, decoration: box(pc[k % 3], b: 2, s: 0, circle: k % 3 == 0),
                      child: Text('${k + 1}', style: t(12, c: pfg[k % 3], ls: 0))),
                  const SizedBox(width: 12),
                  Expanded(child: Text(p.features[k], style: t(15, w: FontWeight.w500, ls: 0, h: 1.4))),
                ]),
              )),
          ])),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 28, 28),
          child: InfoBox(i: i + 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('TECH STACK', style: t(12, w: FontWeight.w700, ls: 3)),
            gap(12),
            Wrap(spacing: 8, runSpacing: 8, children: [for (final s in p.stack) Chip2(s)]),
          ])),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 28, 44),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (p.url != null) ...[
              BButton('Visit website', () => openUri(context, Uri.parse(p.url!)), color: Colors.white, fg: ink, icon: Icons.open_in_new, expand: true),
              gap(18),
            ],
            BButton('Back to projects', () => Navigator.of(context).pop(), color: ink, icon: Icons.arrow_back),
          ]),
        ),
      ]),
    );
  }
}

// ---------- Contact ----------

class Contact extends StatefulWidget {
  const Contact({super.key});
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final nameC = TextEditingController(), msgC = TextEditingController();
  @override
  void dispose() { nameC.dispose(); msgC.dispose(); super.dispose(); }

  Widget field(TextEditingController c, String hint, {int lines = 1}) => Container(
    decoration: const BoxDecoration(boxShadow: [BoxShadow(color: ink, offset: Offset(4, 4), blurRadius: 0)]),
    child: TextField(
      controller: c,
      maxLines: lines,
      style: t(15, w: FontWeight.w500, ls: 0),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: t(15, w: FontWeight.w500, ls: 0, c: Colors.black45),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        border: const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: ink, width: 3)),
        enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: ink, width: 3)),
        focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: blue, width: 4)),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => PageShell('CONTACT', [
    Sec('04 — Contact', 'Let\'s talk',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Reveal(Text('Got a project, an internship, a club role or an idea you want built? Send me a message and I\'ll get back to you.', style: t(16, w: FontWeight.w500, ls: 0, h: 1.55))),
          gap(24),
          Reveal(delay: 100, from: const Offset(-1.2, 0), clip: false,
              Padding(padding: const EdgeInsets.only(right: 8), child: InfoBox(i: 2, color: yellow, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('OPEN TO', style: t(12, w: FontWeight.w700, ls: 3)),
                gap(8),
                Text('Student club roles, internships, hackathon teams and collaborations on mobile, IoT and AI projects.', style: t(15, w: FontWeight.w500, ls: 0, h: 1.5)),
              ])))),
        ])),
    const Marquee('LET\'S BUILD SOMETHING ● ', yellow, ink),
    Sec('Reach me', 'Direct links',
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Column(children: [
            Reveal(delay: 60, from: const Offset(-1.3, 0), clip: false, Row(children: [
              Expanded(child: BButton('Email me', () => openUri(context, mailUri()), expand: true, icon: Icons.mail_outline)),
              const SizedBox(width: 12),
              BButton('Copy', () {
                Clipboard.setData(const ClipboardData(text: email));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('EMAIL COPIED')));
              }, color: Colors.white, fg: ink),
            ])),
            gap(20),
            Reveal(delay: 160, from: const Offset(1.3, 0), clip: false,
                BButton('GitHub', () => openUri(context, Uri.parse(github)), color: blue, expand: true, icon: Icons.code)),
            gap(20),
            Reveal(delay: 260, from: const Offset(-1.3, 0), clip: false,
                BButton('LinkedIn', () => openUri(context, Uri.parse(linkedin)), color: yellow, fg: ink, expand: true, icon: Icons.work_outline)),
          ]),
        )),
    Sec('Quick note', 'Send a message', color: blue, fg: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Reveal(Text('This opens your email app with the message ready to send.', style: t(15, w: FontWeight.w500, ls: 0, c: Colors.white))),
            gap(20),
            field(nameC, 'Your name'),
            gap(20),
            field(msgC, 'Your message', lines: 5),
            gap(24),
            BButton('Send via email', () {
              final n = nameC.text.trim();
              openUri(context, mailUri(subject: 'Message from ${n.isEmpty ? 'your portfolio' : n}', body: msgC.text.trim()));
            }, color: yellow, fg: ink, icon: Icons.send),
          ]),
        )),
    Container(
      width: double.infinity,
      color: ink,
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
      child: Text('© 2026 $fullName · BUILT WITH FLUTTER', style: t(10, w: FontWeight.w700, ls: 2, c: Colors.white54)),
    ),
  ]);
}

// ---------- Shell with color-shutter page transition ----------

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> with SingleTickerProviderStateMixin {
  int _i = 0, _next = 0;
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
    ..addListener(() { if (_c.value >= .5 && _i != _next) setState(() => _i = _next); });
  @override
  void dispose() { _c.dispose(); super.dispose(); }

  void _go(int n) {
    if (n == _next || _c.isAnimating) return;
    setState(() => _next = n);
    _c.forward(from: 0);
  }

  Widget _shutter() => AnimatedBuilder(
    animation: _c,
    builder: (_, __) {
      final v = _c.value;
      return Column(children: [
        for (var k = 0; k < 3; k++)
          Expanded(
            child: Align(
              alignment: v < .5 ? Alignment.centerLeft : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: v == 0 ? 0 : v < .5
                    ? Interval(k * .06, .38 + k * .06, curve: Curves.easeOut).transform(v)
                    : 1 - Interval(.5 + k * .06, .88 + k * .06, curve: Curves.easeOut).transform(v),
                heightFactor: 1,
                child: Container(decoration: BoxDecoration(color: pc[k], border: const Border(bottom: BorderSide(color: ink, width: 4)))),
              ),
            ),
          ),
      ]);
    },
  );

  @override
  Widget build(BuildContext context) {
    final pages = [Home(go: _go), const Projects(), const Contact()];
    const labels = ['HOME', 'PROJECTS', 'CONTACT'];
    return Scaffold(
      body: Stack(children: [
        KeyedSubtree(key: ValueKey(_i), child: pages[_i]),
        IgnorePointer(child: _shutter()),
      ]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: ink, width: 4))),
        child: SafeArea(
          top: false,
          child: Row(children: [
            for (var i = 0; i < 3; i++)
              Expanded(
                child: Semantics(
                  button: true, label: labels[i], selected: _next == i,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _go(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200), curve: Curves.easeOut,
                      color: _next == i ? yellow : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Geo(i, 22, _next == i ? red : Colors.white),
                        const SizedBox(height: 4),
                        Text(labels[i], style: t(11, ls: 2)),
                      ]),
                    ),
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}