import 'package:flutter/material.dart';

import '../models/muyu_model.dart';

class MuyuOptionPanel extends StatelessWidget {
  final List<MuyuModel> imageOptions;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  const MuyuOptionPanel({
    Key? key,
    required this.imageOptions,
    required this.activeIndex,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const EdgeInsets padding =
        EdgeInsets.symmetric(horizontal: 8.0, vertical: 16);
    return Material(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              height: 46,
              alignment: Alignment.center,
              child: const Text(
                "选择木鱼",
                style: labelStyle,
              ),
            ),
            Expanded(
              child: Padding(
                padding: padding,
                child: Row(
                  children: [
                    ...List.generate(
                      imageOptions.length,
                      (index) => Expanded(
                        child: _buildByIndex(index),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//
  Widget _buildByIndex(int index) {
    bool active = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: MuyuTypeeOption(
        option: imageOptions[index],
        active: active,
      ),
    );
  }
}

class MuyuTypeeOption extends StatelessWidget {
  const MuyuTypeeOption(
      {super.key, required this.active, required this.option});

  final bool active;
  final MuyuModel option;

  @override
  Widget build(BuildContext context) {
    const Border activeBorder =
        Border.fromBorderSide(BorderSide(color: Colors.blue));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: !active ? null : activeBorder,
      ),
      child: Column(
        children: [
          Text(option.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(option.src),
            ),
          ),
          Text('每次功德 +${option.min}~${option.max}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
