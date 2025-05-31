import 'package:flutter/material.dart';
import 'package:movie_app/app_colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Filmes",
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
                        child: Text("Ok"),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                        ),
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
