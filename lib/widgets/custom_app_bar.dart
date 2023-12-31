import 'package:flutter/material.dart';

import '../config/config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          color: AppColors.textColor,
        ),
      ),
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.textColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
