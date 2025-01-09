import 'package:flutter/material.dart';
import 'package:spa_client_app/const/const.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.onChanged,
  });

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        filled: true,
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.grey.shade500),
        prefixIconColor: Colors.grey.shade500,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: mainBlueColor, width: 2),
        ),
        prefixIcon: const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
