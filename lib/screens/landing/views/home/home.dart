import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spa_client_app/global/widgets/shadowed_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverAppBar(
            leading: CircleAvatar(radius: 30),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShadowedText(text: 'User Name'),
                Text(
                  'username@email.com',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(20),
          sliver: SliverToBoxAdapter(child: ShadowedText(text: 'Assessments')),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: List.generate(
                2,
                (index) => Expanded(
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              index == 0
                                  ? Icons.assessment_outlined
                                  : Icons.assessment_rounded,
                              size: 90),
                          ShadowedText(
                            text: index == 0
                                ? 'Hardware Assessment'
                                : 'Software Assessment',
                            textAling: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          sliver:
              SliverToBoxAdapter(child: ShadowedText(text: 'Walk Off Plan')),
        ),
        const SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: DaysTabBar(),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          sliver: SliverList.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 8,
                  child: ListTile(
                    title: Text('WOP - $index'),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

//  leading: const CircleAvatar(radius: 30),
//           title: const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ShadowedText(text: 'User Name'),
//               Text(
//                 'username@email.com',
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13,
//                 ),
//               )
//             ],
//           ),

// Column(
//           children: [
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: ShadowedText(text: 'Assessments'),
//             ),
//             Row(
//               children: List.generate(
//                 2,
//                 (index) => Expanded(
//                   child: Card(
//                     elevation: 8,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                               index == 0
//                                   ? Icons.assessment_outlined
//                                   : Icons.assessment_rounded,
//                               size: 90),
//                           ShadowedText(
//                             text: index == 0
//                                 ? 'Hardware Assessment'
//                                 : 'Software Assessment',
//                             textAling: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: ShadowedText(text: 'Walk Off Plan'),
//             ),
//             const DaysTabBar(),
//             Expanded(
//               child: ListView.builder(
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       title: Text('WOP - $index'),
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),

class DaysTabBar extends StatefulWidget {
  const DaysTabBar({super.key});
  @override
  State<DaysTabBar> createState() => _DaysTabBarState();
}

class _DaysTabBarState extends State<DaysTabBar>
    with SingleTickerProviderStateMixin {
  late TabController controller = TabController(length: 7, vsync: this);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      padding: EdgeInsets.zero,
      tabs: List.generate(
        7,
        (index) => Tab(
          child: Text('Day: ${index + 1}'),
        ),
      ),
    );
  }
}
