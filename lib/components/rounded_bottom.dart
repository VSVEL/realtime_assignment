import 'package:flutter/material.dart';

class PositionSelectionBottomSheet extends StatelessWidget {
  final List<String> positions;
  final Function(String) onPositionSelected;

  PositionSelectionBottomSheet({
    required this.positions,
    required this.onPositionSelected,
  });

  void _onItemSelected(BuildContext context, String position) {
    onPositionSelected(position);
    Navigator.of(context).pop(); // Close the bottom sheet after selection
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: positions.map((position) {
          return ListTile(
            title: Text(position),
            onTap: () => _onItemSelected(context, position),
          );
        }).toList(),
      ),
    );
  }

  static void showPositionSelectionBottomSheet(
      BuildContext context, List<String> positions, Function(String) onPositionSelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) => PositionSelectionBottomSheet(
        positions: positions,
        onPositionSelected: onPositionSelected,
      ),
    );
  }
}
