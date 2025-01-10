import 'package:flutter/material.dart';
import 'package:spa_client_app/const/const.dart';
import 'package:spa_client_app/models/apps/landing_pages_model/landing_pages_model.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: LandingPagesModel.list.length,
        itemBuilder: (context, index) => LandingPagesModel.list[index].route,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.grey,
        selectedIconTheme: IconTheme.of(context).copyWith(color: mainBlueColor),
        unselectedIconTheme: IconTheme.of(context).copyWith(color: Colors.grey),
        onTap: (value) {},
        items: List.generate(
          LandingPagesModel.list.length,
          (index) {
            final item = LandingPagesModel.list[index];
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.name,
            );
          },
        ),
      ),
    );
  }
}
