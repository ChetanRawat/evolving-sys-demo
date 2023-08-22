import 'package:evolving_sys_demo/pagination/src/ui/widgets/buttons/paginator_button.dart';
import 'package:flutter/material.dart';

/// A paginator button that has an [Icon] as a child, instead of text. The icon
/// scales with the available space, depending on the size of the button.
class PaginatorIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const PaginatorIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginatorButton(
      onPressed: onPressed,
      // size icon depending on available height
      child: FittedBox(
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color:Colors.black,
                  width: 1
              )
          ),
          child: Icon(icon),
        )/*Icon(icon)*/,
      ),
    );
  }
}
