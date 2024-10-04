import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../custom_icons.dart';

class FallingLeave extends StatefulWidget {
  const FallingLeave({
    super.key,
    required this.leftPositionInitial,
    required this.color,
    required this.fallDuration,
    required this.isReverted,
  });

  final double leftPositionInitial;
  final Color color;
  final int fallDuration;
  final bool isReverted;

  @override
  State<FallingLeave> createState() => _FallingLeaveState();
}

class _FallingLeaveState extends State<FallingLeave>
    with SingleTickerProviderStateMixin {
  double topPosition = -50;
  late double leftPosition;
  bool isDragging = false;
  late AnimationController _controller;
  late Animation<double> _fallAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000 + widget.fallDuration),
    );

    // Define the animation
    _fallAnimation = Tween<double>(
      begin: topPosition,
      end: MediaQuery.of(context).size.height + 50,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Listen to the animation and update the position
    _controller.addListener(() {
      if (!isDragging) {
        setState(() {
          topPosition = _fallAnimation.value;
        });
      }
    });

    // Start the animation
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    leftPosition = widget.leftPositionInitial;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: isDragging ? Duration.zero : Duration(milliseconds: 50),
      left: leftPosition,
      top: topPosition,
      child: Transform(
        transform: Matrix4.identity()
          ..scale(widget.isReverted ? -1.0 : 1.0, 1.0),
        child: GestureDetector(
          onPanStart: (_) {
            setState(() {
              isDragging = true;
            });
            _controller.stop();
          },
          onPanUpdate: (details) {
            setState(() {
              topPosition += details.delta.dy;
              double horizontalDrag = details.delta.dx;
              if (widget.isReverted) {
                horizontalDrag =
                    -horizontalDrag; // Reverse the drag direction if mirrored
              }
              leftPosition += horizontalDrag;
            });
          },
          onPanEnd: (details) async {
            // Create some inertia in the direction of the drag
            for (int i = 0; i < 10; i++) {
              await Future.delayed(Duration(milliseconds: 10));
              setState(() {
                topPosition += details.velocity.pixelsPerSecond.dy / 100;
                double horizontalDrag =
                    details.velocity.pixelsPerSecond.dx / 100;
                if (widget.isReverted) {
                  horizontalDrag =
                      -horizontalDrag; // Reverse the drag direction if mirrored
                }
                leftPosition += horizontalDrag;
              });
            }
            setState(() {
              isDragging = false;
            });
            // Restart falling animation after drag ends
            _fallAnimation = Tween<double>(
              begin: topPosition,
              end: MediaQuery.of(context).size.height + 50,
            ).animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.easeInOut,
            ));
            _controller.duration = Duration(
                milliseconds:
                    ((MediaQuery.of(context).size.height - topPosition) /
                            MediaQuery.of(context).size.height *
                            (3000 + widget.fallDuration))
                        .toInt());
            _controller.forward(from: 0);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              CustomIcons.leaf,
              color: widget.color,
              size: 50.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            ),
          ),
        ),
      ),
    );
  }
}
