part of '../main_app_bar.dart';

final class AppBarFadeInOptions {
  static const double defaultThreshold = 52.0;

  /// [ScrollController] of page's body, typically [ListView] or [SingleChildScrollView] widget.
  ///
  /// If this is not null, opacity of [title] or [titleWidget] is animated from fully hidden to
  /// fully visible while scrolling along [fadeInScrollController]'s main axis.
  /// [title] or [titleWidget] becomes fully opaque after [threshold] pixels scrolled.
  final ScrollController scrollController;

  /// After this amount of pixels have been scrolled, [title] or [titleWidget] is fully visible.
  final double threshold;

  const AppBarFadeInOptions({
    required this.scrollController,
    this.threshold = defaultThreshold,
  });
}
