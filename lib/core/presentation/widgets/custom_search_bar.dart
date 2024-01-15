import 'package:flutter/material.dart';
import 'package:moviedb/core/presentation/widgets/search_icon_button.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  CustomSearchBar({
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
  final Function(String)? onSearchAction;

  @override
  Widget build(BuildContext context) {
    final textField = TextFormField(
      controller: _controller,
      readOnly: readOnly,
      decoration: const InputDecoration(
        hintText: "Search Here ...",
      ),
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onFieldSubmitted: onSearchAction,
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
          onPressed: () {
            if (onSearchAction != null) {
              onSearchAction?.call(_controller.text);
            }
          },
        ),
      ],
    );
  }
}
