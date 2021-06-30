import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  /// [HomePage] onde é mostrado tudo relacionado com todas as [TELAS]
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  final pages = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.yellow,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152.0),
        child: Container(
          height: 152.0,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: "Olá, ",
                  style: AppTextStyles.titleRegular,
                  children: [
                    TextSpan(
                      text: "Willys Silva",
                      style: AppTextStyles.titleBoldBackground,
                    )
                  ],
                ),
              ),
              subtitle: Text(
                "Matenha suas contas em dia",
                style: AppTextStyles.captionBoldShape,
              ),
              trailing: Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        ),
      ),
      body: pages[controller.currentPage],
      bottomNavigationBar: Container(
        height: 90.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home
            IconButton(
                onPressed: () {
                  controller.setPage(0);
                  setState(() => {});
                },
                icon: Icon(Icons.home)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/barcode_scanner");
                setState(() => {});
              },
              child: Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Icon(
                  Icons.add,
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                controller.setPage(2);
                setState(() => {});
              },
              icon: Icon(Icons.description_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
