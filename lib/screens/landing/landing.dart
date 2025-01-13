import 'package:flutter/material.dart';
import 'package:spa_client_app/const/const.dart';
import 'package:spa_client_app/models/apps/landing_pages_model/landing_pages_model.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final pageCtrl = PageController();
    return Scaffold(
      body: PageView.builder(
        controller: pageCtrl,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: LandingPagesModel.list.length,
        itemBuilder: (context, index) => LandingPagesModel.list[index].route,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.grey,
        selectedIconTheme: IconTheme.of(context).copyWith(color: mainBlueColor),
        unselectedIconTheme: IconTheme.of(context).copyWith(color: Colors.grey),
        onTap: (value) => pageCtrl.animateToPage(value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut),
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
