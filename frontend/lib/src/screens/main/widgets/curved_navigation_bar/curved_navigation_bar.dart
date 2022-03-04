import 'package:flutter/material.dart';
import 'nav_button.dart';
import 'nav_custom_painter.dart';

GlobalKey bottomBarKey = new GlobalKey(debugLabel: 'btm_app_bar');

class CurvedNavigationBar extends StatefulWidget {
  final List<Icon> items;
  final int index;
  final Color color;
  final Color buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int> onTap;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;

  CurvedNavigationBar({
    Key key,
    @required this.items,
    this.index = 0,
    this.color,
    this.buttonBackgroundColor,
    this.backgroundColor = Colors.black,
    this.onTap,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.height = 75.0,
  })  : assert(items != null),
        assert(items.length >= 1),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= 75.0),
        super(key: key);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar> with SingleTickerProviderStateMixin {
  double _startingPos;
  int _endingIndex = 0;
  double _pos;
  double _buttonHide = 0;
  Icon _icon;
  AnimationController _animationController;
  int _length;
  bool changed = false;

  @override
  void initState() {
    super.initState();
    _icon = _icon = Icon(
      widget.items[_endingIndex].icon,
      color: Color(0xFFC75414),
      size: widget.items[_endingIndex].size,
    );
    _length = widget.items.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = Icon(
            widget.items[_endingIndex].icon,
            color: Color(0xFFC75414),
            size: widget.items[_endingIndex].size,
          );
        }
        _buttonHide = (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition, duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: -40 - (75.0 - widget.height),
            left: _pos * size.width,
            width: size.width / _length,
            child: Center(
              child: Transform.translate(
                offset: Offset(
                  0,
                  -(1 - _buttonHide) * 80,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _icon,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0 - (75.0 - widget.height),
            child: CustomPaint(
              painter: NavCustomPainter(_pos, _length, widget.color),
              child: Container(
                height: 75.0,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0 - (75.0 - widget.height),
            child: SizedBox(
                height: 100.0,
                child: Row(
                    children: widget.items.map((item) {
                  return NavButton(
                    onTap: buttonTap,
                    position: _pos,
                    length: _length,
                    index: widget.items.indexOf(item),
                    child: item,
                  );
                }).toList())),
          ),
        ],
      ),
    );
  }

  int getCurrentIndex() {
    return _endingIndex;
  }

  Future<void> buttonTap(int index) async {
    if (widget.onTap != null) {
      widget.onTap(index);
    }
    final newPosition = index / _length;
    if (!changed) {
      widget.items[0] = Icon(
        widget.items[0].icon,
        color: Colors.white,
        size: widget.items[0].size,
      );
      changed = true;
    }
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(newPosition, duration: widget.animationDuration, curve: widget.animationCurve);
    });
  }
}
