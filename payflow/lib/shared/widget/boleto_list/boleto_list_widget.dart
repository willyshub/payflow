import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widget/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widget/boleto_tile/boleto_tile_widget.dart';

class BoletoListWidget extends StatefulWidget {
  const BoletoListWidget({Key? key}) : super(key: key);

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  final controller = BoletolistController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
        valueListenable: controller.boletosNotifier,
        builder: (_, boletos, __) {
          return Column(
              children: boletos
                  .map(
                    (e) => AnimatedCard(
                      onRemove: (){},
                      direction: AnimatedCardDirection.left,
                      child: BoletoTileWidget(data: e),
                    ),
                  )
                  .toList());
        });
  }
}
