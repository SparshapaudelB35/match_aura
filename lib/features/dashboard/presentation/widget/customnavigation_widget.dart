import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      Icons.home,
      Icons.favorite_border,
      Icons.people,
      Icons.messenger_outline,
      Icons.person,
    ];

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onItemSelected(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 5,
                  width: isSelected ? 30 : 0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8E2DE2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  items[index],
                  size: 30,
                  color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
                ),
                
                // Line indicator
                
              ],
            ),
          );
        }),
      ),
    );
  }
}
