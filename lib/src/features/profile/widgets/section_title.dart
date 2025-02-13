part of '../profile_page.dart';

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPagePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.h24,
          Text(title, style: context.textTheme.displaySmall),
          Gaps.h16,
        ],
      ),
    );
  }
}
