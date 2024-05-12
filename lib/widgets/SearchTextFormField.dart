import 'package:flutter/material.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 8,
      ),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(32),
        child: SizedBox(
          width: 300,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Search by name',
              hintStyle: textTheme.bodyMedium!.copyWith(
                color: Colors.black,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.orange,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
