import 'package:connect_me_app/presentation/view/common/custom_card.dart';
import 'package:connect_me_app/presentation/view/common/details.dart';
import 'package:connect_me_app/presentation/view/common/overview.dart';
import 'package:connect_me_app/presentation/view/common/rating&review.dart';
import 'package:connect_me_app/presentation/view/common/search_bar.dart';
import 'package:connect_me_app/presentation/view/common/showbottomSheet.dart';
import 'package:connect_me_app/theme/app_color.dart';
import 'package:connect_me_app/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppTheme.mainColor,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi Rohan,',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text('Welcome to Buzz'),
                const SizedBox(
                  height: 12,
                ),
                SearchBarList(),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '10 Business',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('Recently added to favorite'),
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.right_chevron))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Top searched business categories near you',
                  style: AppTextStyles.bodyStyle,
                ),
                const SizedBox(
                  height: 12,
                ),

                //business near you
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Business near you',
                          style: AppTextStyles.bodyStyle,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.right_chevron),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomInfoCard(
                            title: 'College',
                            name: 'College of Applied Business and Technology',
                            address: 'Gangahity, Chabahil, Kathmandu 44600',
                            distance: '3.1 km away',
                            time: '10 am - 5 pm',
                            rating: '3.1 rating',
                            onTap: () {
                              // showModalBottomSheet(
                              //     context: context,
                              //     builder: (context) {
                              //       return Container(
                              //         // child:
                              //         //   TabBar(
                              //         //     controller: tabController,
                              //         //     labelColor: Colors.blue,
                              //         //     unselectedLabelColor: Colors.grey,
                              //         //     indicatorColor: Colors.blue,
                              //         //     tabs: [
                              //         //       Tab(
                              //         //         text: 'Overview',
                              //         //       ),
                              //         //       Tab(
                              //         //         text: 'Rating&Review',
                              //         //       ),
                              //         //       Tab(
                              //         //         text: 'Details',
                              //         //       ),
                              //         //     ],
                              //         //   ),
                              //         );

                              //     });
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => showCustomBottomSheet(context: null)));
                              showCustomBottomSheet(
                                context: context,
                                initialTabIndex: 0,
                                heightFactor:
                                    0.8, // Set the height to 70% of the screen height
                                tabBarViews: [
                                  OverView(
                                    
                                  ),
                                  RatingAndReviewTab(),
                                  Details(),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),

                //Business hot in town
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Business hot in town',
                          style: AppTextStyles.bodyStyle,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.right_chevron),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomInfoCard(
                            title: 'College',
                            name: 'College of Applied Business and Technology',
                            address: 'Gangahity, Chabahil, Kathmandu 44600',
                            distance: '3.1 km away',
                            time: '10 am - 5 pm',
                            rating: '3.1 rating',
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),

                //Recommended to you
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recommended to you',
                          style: AppTextStyles.bodyStyle,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.right_chevron),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomInfoCard(
                            title: 'College',
                            name: 'College of Applied Business and Technology',
                            address: 'Gangahity, Chabahil, Kathmandu 44600',
                            distance: '3.1 km away',
                            time: '10 am - 5 pm',
                            rating: '3.1 rating',
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCustomBottomSheet({
    required BuildContext context,
    int initialTabIndex = 0,
    required List<Widget> tabBarViews,
    double?
        heightFactor, // This allows you to set the height as a factor of the screen height
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      context: context,
      builder: (context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double bottomSheetHeight = heightFactor != null
            ? screenHeight * heightFactor
            : screenHeight /
                2; // Default to half of screen height if not provided

        return Container(
          height: bottomSheetHeight, // Set the height of the bottom sheet
          padding: MediaQuery.of(context).viewInsets,
          child: DefaultTabController(
            length: 3,
            initialIndex: initialTabIndex,
            child: Column(
              children: <Widget>[
                TabBar(
                  labelColor: Colors.red,
                  tabs: <Widget>[
                    Tab(text: 'Overview'),
                    Tab(text: 'Rating & Review'),
                    Tab(text: 'Details'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: tabBarViews,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}





