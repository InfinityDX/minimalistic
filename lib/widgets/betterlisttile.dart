import 'package:flutter/material.dart';

class BetterListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final double? height;
  final double? width;
  final Color? color;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final bool? debugBorder;
  final Function()? onTap;

  const BetterListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.height,
    this.width,
    this.trailing,
    this.boxShadow,
    this.color,
    this.borderRadius,
    this.debugBorder,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: debugBorder == null || debugBorder == false
            ? null
            : Border.all(color: Colors.red, width: 2),
        boxShadow: boxShadow ?? [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Row(
            children: [
              leading ?? Container(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title ?? Container(),
                    title != null && subtitle != null
                        ? const SizedBox(height: 1)
                        : Container(),
                    subtitle ?? Container(),
                  ],
                ),
              ),
              trailing ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
