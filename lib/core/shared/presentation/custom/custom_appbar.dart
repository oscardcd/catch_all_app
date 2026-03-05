import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:catch_all_app/core/core.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.onTapAction,
    this.needBack = false,
    this.centerText = false,
    this.automaticallyImplyLeading = true,
    super.key,
    this.action,
    this.onBack,
    required this.titleWidget,
    this.customTitleSize,
  });

  final VoidCallback? onTapAction;
  final VoidCallback? onBack;
  final Widget? action;

  final bool centerText;

  final bool automaticallyImplyLeading;
  final bool needBack;
  final Widget titleWidget;
  final double? customTitleSize;

  @override
  Size get preferredSize {
    return const Size.fromHeight(56);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: needBack
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                // color: context.colorScheme.primary,
              ),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : null,
      // backgroundColor: context.colorScheme.secondary,
      actions: [
        if (onTapAction != null)
          GestureDetector(
            onTap: onTapAction,
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: action,
            ),
          )
        else
          sizedBoxShrink,
      ],
      centerTitle: centerText,
      title: titleWidget,
      bottomOpacity: 0,
      elevation: 0,
    );
  }
}
