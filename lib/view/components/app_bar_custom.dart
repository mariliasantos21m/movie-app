import 'package:flutter/material.dart';
import 'package:movie_app/app_colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.canPopOf(context) ?? false;

    return AppBar(
      leading:
          canPop
              ? IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.text,
                ),
              )
              : null,
      title: Text(
        title,
        style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    backgroundColor: AppColors.card,
                    contentTextStyle: TextStyle(color: AppColors.subTitle),
                    titleTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                    title: Text("Equipe:"),
                    content: SizedBox(
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dimas Lima da Costa"),
                          Text("João Victor Marques"),
                          Text("Marília Santos do Nascimento"),
                          Text("Thiago Maia"),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                        ),
                        child: Text("OK"),
                      ),
                    ],
                  ),
            );
          },
          icon: Icon(Icons.info, color: AppColors.text),
        ),
      ],
      backgroundColor: AppColors.background,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
