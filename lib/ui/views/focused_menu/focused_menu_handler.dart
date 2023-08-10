import 'package:flutter/material.dart';
import 'package:smartnote/ui/views/focused_menu/focused_menu_details.dart';

class FocusedMenuHandler extends StatefulWidget {
  final Widget child, menuContent;
  const FocusedMenuHandler(
      {super.key, required this.child, required this.menuContent});

  @override
  State<FocusedMenuHandler> createState() => _FocusedMenuHandlerState();
}

class _FocusedMenuHandlerState extends State<FocusedMenuHandler> {
  GlobalKey containerKey = GlobalKey();
  Offset childOffset = const Offset(0, 0);
  late Size childSize;

  getOffset() {
    dynamic renderBox = containerKey.currentContext!.findRenderObject()!;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      childOffset = Offset(offset.dx, offset.dy);
      childSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: containerKey,
        onLongPress: () async {
          getOffset();
          await Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 100),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    animation = Tween(begin: 0.0, end: 1.0).animate(animation);
                    return FadeTransition(
                        opacity: animation,
                        child: FocusedMenuDetails(
                          menuContent: widget.menuContent,
                          childOffset: childOffset,
                          childSize: childSize,
                          child: widget.child,
                        ));
                  },
                  fullscreenDialog: true,
                  opaque: false));
        },
        child: widget.child);
  }
}
