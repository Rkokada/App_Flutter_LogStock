import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logstock/rt_db_teste/fab_vertical_delegate.dart';
import 'package:logstock/rt_db_teste/insert_data.dart';

class FabMenuButton extends StatefulWidget {
  const FabMenuButton({Key? key}) : super(key: key);

  @override
  State<FabMenuButton> createState() => _FabMenuButtonState();
}

class _FabMenuButtonState extends State<FabMenuButton>
    with SingleTickerProviderStateMixin {
  final actionButtonColor = Colors.purple;

  late AnimationController animation;
  final menuIsOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  toggleMenu() {
    menuIsOpen.value ? animation.reverse() : animation.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      clipBehavior: Clip.none,
      delegate: FabVerticalDelegate(
        animation: animation,
      ),
      children: [
        FloatingActionButton(
          heroTag: Text('Menu'),
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animation,
          ),
          onPressed: () => toggleMenu(),
          backgroundColor: Colors.deepPurple,
        ),
        FloatingActionButton(
          heroTag: Text('Adicionar Item'),
          child: Icon(Icons.post_add_outlined),
          onPressed: () {
            Get.to(InsertData());
          },
          backgroundColor: actionButtonColor,
        ),
        FloatingActionButton(
          heroTag: Text('Leitor QR Code'),
          child: Icon(Icons.qr_code_outlined),
          onPressed: () {},
          backgroundColor: actionButtonColor,
        ),
        FloatingActionButton(
          heroTag: Text('Relatório PDF'),
          child: Icon(Icons.picture_as_pdf_outlined),
          onPressed: () {},
          backgroundColor: actionButtonColor,
        ),
      ],
    );
  }
}
