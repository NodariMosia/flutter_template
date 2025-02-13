import 'package:flutter/material.dart';

import 'package:flutter_template/src/constants/widget_sizings.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';

part './models/app_bar_fade_in_options.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onTitle;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final PreferredSizeWidget? bottomWidget;
  final double rightPadding;
  final double elevation;
  final double scrolledUnderElevation;
  final bool isTransparent;

  final AppBarFadeInOptions? fadeInOptions;

  const MainAppBar({
    this.title = '',
    this.onBack,
    this.onTitle,
    this.actions,
    this.titleWidget,
    this.bottomWidget,
    this.rightPadding = 16,
    this.elevation = 0,
    this.scrolledUnderElevation = 4,
    this.isTransparent = false,
    this.fadeInOptions,
    super.key,
  });

  const MainAppBar.placeholder({Key? key})
      : this(
          title: '',
          onBack: null,
          onTitle: null,
          actions: null,
          titleWidget: null,
          bottomWidget: null,
          rightPadding: 16,
          elevation: 0,
          scrolledUnderElevation: 4,
          isTransparent: false,
          key: key,
        );

  static AppBar zeroHeight() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget appBarTitle = titleWidget ??
        GestureDetector(
          onTap: onTitle,
          child: title.isEmpty ? const SizedBox() : FittedBox(child: Text(title)),
        );

    if (fadeInOptions != null) {
      appBarTitle = ListenableBuilder(
        listenable: fadeInOptions!.scrollController,
        // builder: (_, Widget? child) => Opacity(
        //   opacity: fadeInOptions!.scrollController.offset.clamp(0, fadeInOptions!.threshold) /
        //       fadeInOptions!.threshold,
        //   child: child,
        // ),
        builder: (_, Widget? child) => AnimatedOpacity(
          duration: Duration.zero,
          opacity: fadeInOptions!.scrollController.offset.clamp(0, fadeInOptions!.threshold) /
              fadeInOptions!.threshold,
          child: child,
        ),
        child: appBarTitle,
      );
    }

    return AppBar(
      elevation: isTransparent ? 0 : elevation,
      scrolledUnderElevation: isTransparent ? 0 : scrolledUnderElevation,
      automaticallyImplyLeading: false,
      leadingWidth: 50,
      backgroundColor: isTransparent ? Colors.transparent : context.colorScheme.surface,
      leading: onBack == null
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              iconSize: 23,
              onPressed: onBack,
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: context.colorScheme.onSurface,
              ),
            ),
      titleSpacing: 0,
      centerTitle: true,
      title: appBarTitle,
      actions: [...?actions, SizedBox(width: rightPadding)],
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(
      kAppToolbarHeight + (bottomWidget?.preferredSize.height ?? 0),
    );
  }
}
