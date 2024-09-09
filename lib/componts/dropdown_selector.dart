import 'package:flutter/material.dart';

class DropdownSelector<T> extends StatelessWidget {
  final DropdownSelectorModel<T>? value;
  final List<DropdownSelectorModel<T>> items;
  final ValueChanged<DropdownSelectorModel<T>?>? onChanged;

  final bool _underline;

  const DropdownSelector({
    super.key,
    required this.value,
    required this.items,
    this.onChanged,
  }) : _underline = false;

  const DropdownSelector.underline({
    super.key,
    required this.value,
    required this.items,
    this.onChanged,
  }): _underline = true;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<DropdownSelectorModel<T>>(
      underline: _underline ?  Container(
        height: 2,
        color: Colors.grey,
      ) : null,
      value: value,
      items: items.map((DropdownSelectorModel<T> item) {
        return DropdownMenuItem<DropdownSelectorModel<T>>(
          value: item,
          child: Text(item.selectedName),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}


class DropdownSelectorModel<T>{
  final String selectedName;
  final T selectedType;

  DropdownSelectorModel({required this.selectedName, required this.selectedType});
}