import 'package:flutter/material.dart';
import 'package:moviedb/core/presentation/widgets/search_icon_button.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.onFieldTap,
    this.onSearchAction,
  });

  final bool readOnly;
  final bool autofocus;
  final Function(String)? onChanged;
  final VoidCallback? onFieldTap;
  final VoidCallback? onSearchAction;

  @override
  Widget build(BuildContext context) {
    final textField = TextFormField(
      readOnly: readOnly,
      decoration: const InputDecoration(
        hintText: "Search Here ...",
      ),
      autofocus: autofocus,
      onChanged: onChanged,
    );

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onFieldTap,
            child: onFieldTap == null
                ? textField
                : AbsorbPointer(child: textField),
          ),
        ),
        const SizedBox(width: 23),
        SearchIconButton(
          onPressed: onSearchAction,
        ),
      ],
    );
  }
}
