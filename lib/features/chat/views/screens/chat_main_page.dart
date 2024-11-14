import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/chat/views/widgets/custom_listtile.dart';
import 'package:shopsyncseller/features/chat/views/widgets/search_bar.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/widgets/menu_drawer.dart';

class ChatMainPage extends StatelessWidget {
  const ChatMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
              ),
            )
          ],
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            CustomSearchBar(),
            Divider(
              color: AppColors().appWhite,
            ),
            Expanded(
              child: CustomListTile(
                size: 5,
              ),
            ),
          ],
        ));
  }
}
