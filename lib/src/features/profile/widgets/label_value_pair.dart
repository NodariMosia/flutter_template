part of '../profile_page.dart';

class _LabelValuePair extends StatelessWidget {
  final String label;
  final String value;

  const _LabelValuePair(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.textTheme.labelLarge?.copyWith(color: context.colorScheme.primary);
    final valueStyle = context.textTheme.titleMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: labelStyle),
          Gaps.h2,
          Text(value, style: valueStyle),
          Gaps.h12,
        ],
      ),
    );
  }
}
