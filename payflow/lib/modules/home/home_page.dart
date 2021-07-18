import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  /// [HomePage] onde é mostrado tudo relacionado com todas as [TELAS]
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  // final pages = [
  //   MeusBoletosPage(
  //     key: UniqueKey(),
  //   ),
  //   ExtractPage(
  //     key: UniqueKey(),
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152.0),
        child: Container(
          height: 140.0,
          color: AppColors.primary,
          child: Padding(
            padding: EdgeInsets.only(top: _size.viewPadding.top * 1.5),
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: "Olá, ",
                  style: AppTextStyles.titleRegular,
                  children: [
                    TextSpan(
                      text: "${widget.user.name}",
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
                    image: DecorationImage(
                        image: NetworkImage("${widget.user.photoURL}")),
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        ),
      ),
      body: [
        MeusBoletosPage(
          key: UniqueKey(),
        ),
        ExtractPage(
          key: UniqueKey(),
        ),
      ][controller.currentPage],
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
                icon: Icon(
                  Icons.home,
                  color: controller.currentPage == 0
                      ? AppColors.primary
                      : AppColors.body,
                )),
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, "/insert_boleto");
                //await Navigator.pushNamed(context, "/barcode_scanner"); TODO - REMOVER
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
                controller.setPage(1);
                setState(() => {});
              },
              icon: Icon(
                Icons.description_outlined,
                color: controller.currentPage == 1
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
