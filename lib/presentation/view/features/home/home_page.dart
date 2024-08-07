import 'package:connect_me_app/presentation/view/common/custom_card.dart';
import 'package:connect_me_app/presentation/view/features/search/search_bar.dart';
import 'package:connect_me_app/theme/app_color.dart';
import 'package:connect_me_app/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                            onTap: () {},
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
}
