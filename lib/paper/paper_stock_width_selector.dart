import 'package:flutter/material.dart';

class StockWidthSelector extends StatelessWidget {
  final List<double> supportStorkWidths;
  final ValueChanged<int> onSelect;
  final int activeIndex;
  final Color color;

  const StockWidthSelector(
      {super.key,
      required this.supportStorkWidths,
      required this.onSelect,
      required this.activeIndex,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          supportStorkWidths.length,
          (index) => _buildByIndex(index),
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    final isActive = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        width: 70,
        height: 20,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: isActive ? Border.all(color: Colors.blue) : null
        ),
        child: Container(
          width: 50,
          height: supportStorkWidths[index],
          color: color,
        ),
      ),
    );
  }
}


