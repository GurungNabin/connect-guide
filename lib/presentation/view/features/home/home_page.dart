import 'package:connect_me_app/data/busniness_data.dart';
import 'package:connect_me_app/model/business/business_model.dart';
import 'package:connect_me_app/presentation/view/common/custom_card_list.dart';
import 'package:connect_me_app/presentation/view/common/details.dart';
import 'package:connect_me_app/presentation/view/common/overview.dart';
import 'package:connect_me_app/presentation/view/common/rating&review.dart';
import 'package:connect_me_app/presentation/view/features/bottom_navigation/mybottom_nav_bar.dart';
import 'package:connect_me_app/presentation/view/features/search/search_screen.dart';
import 'package:connect_me_app/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late Future<List<Result>> businessData;
  int favoriteCount = 0; // Add variable to hold favorite count
  String searchText = "";
  String selectedCategory = "All";
  List<Result> allBusinesses = [];
  List<Result> filteredBusinesses = [];

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    businessData = BusinessService().fetchBusinessData();
    _loadFavoriteCount(); // Load the favorite count when the widget initializes
    super.initState();
  }

  List<Result> _applyFilters(List<Result> businesses) {
    return businesses.where((business) {
      final matchesSearchText = business.name != null &&
          business.name!.toLowerCase().contains(searchText.toLowerCase());
      final matchesCategory = selectedCategory == "All" ||
          (business.category != null &&
              business.category!.toLowerCase() ==
                  selectedCategory.toLowerCase());
      return matchesSearchText && matchesCategory;
    }).toList();
  }

  void _filterBusinesses() {
    setState(() {
      filteredBusinesses = _applyFilters(allBusinesses);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> _updateFavoriteCount() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    setState(() {
      favoriteCount = keys.length;
    });
  }

  void _onFavoriteStatusChanged() {
    setState(() {
      _updateFavoriteCount();
    });
  }

  // Method to load favorite count from SharedPreferences
  Future<void> _loadFavoriteCount() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    setState(() {
      favoriteCount = keys.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: _SearchBarDelegate(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to the search screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const BottomNavBar(
                    //       initialIndex: 2,
                    //     ),
                    //   ),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(initialIndex: 2),
                      ),
                    );
                  },
                  child: AbsorbPointer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                              _filterBusinesses();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              pinned: true,
            ),
            FutureBuilder<List<Result>>(
              future: businessData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('Failed to load business data')),
                  );
                } else if (snapshot.hasData) {
                  final businesses = snapshot.data!;

                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$favoriteCount Business',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text('Recently added to favorite'),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon:
                                      const Icon(CupertinoIcons.right_chevron),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Top searched business categories near you',
                            style: AppTextStyles.bodyStyle,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Business near you
                        _buildBusinessSection(
                          title: 'Business near you',
                          businesses: businesses,
                        ),

                        // Business hot in town
                        _buildBusinessSection(
                          title: 'Business hot in town',
                          businesses: businesses,
                        ),

                        // Recommended to you
                        _buildBusinessSection(
                          title: 'Recommended to you',
                          businesses: businesses,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('No data available')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessSection({
    required String title,
    required List<Result> businesses,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: AppTextStyles.bodyStyle,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.right_chevron),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: businesses.length,
            itemBuilder: (BuildContext context, int index) {
              final business = businesses[index];
              // return CustomInfoCard(
              //   title: business.category ?? 'No category',
              //   name: business.name ?? 'No name',
              //   address: business.location?.toString() ?? 'No address',
              //   distance: '3.1 km away',
              //   time: '10 am - 5 pm',
              //   rating: business.rating,
              //   onTap: () {
              //     showCustomBottomSheet(
              //       context: context,
              //       initialTabIndex: 0,
              //       heightFactor: 0.8,
              //       tabBarViews: [
              //         OverView(
              //           business: business,
              //           onFavoriteStatusChanged: _onFavoriteStatusChanged,
              //         ),
              //         RatingAndReviewTab(
              //           reviews: business.reviews ?? [],
              //         ),
              //         Details(
              //           business: business,
              //         ),
              //       ],
              //     );
              //   },
              // );
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: CustomInfoCardList(
                  title: business.category ?? 'No category',
                  name: business.name ?? 'No name',
                  address: business.location?.toString() ?? 'No address',
                  distance: '3.1 km away',
                  time: '10 am - 5 pm',
                  rating: business.rating,
                  imageUrl: (business.photos != null &&
                          business.photos!.isNotEmpty)
                      ? business.photos![0] // Safe access to the first photo
                      : null, // Default to null if photos is null or empty
                  onTap: () {
                    showCustomBottomSheet(
                      context: context,
                      initialTabIndex: 0,
                      heightFactor: 0.8,
                      tabBarViews: [
                        OverView(
                          business: business,
                          onFavoriteStatusChanged: _onFavoriteStatusChanged,
                        ),
                        RatingAndReviewTab(
                          // reviews: business.reviews ?? [],
                          // Line 788
                          reviews: business.reviews?.cast() ?? [],
                        ),
                        Details(
                          business: business,
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void showCustomBottomSheet({
    required BuildContext context,
    int initialTabIndex = 0,
    required List<Widget> tabBarViews,
    double? heightFactor,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      context: context,
      builder: (context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double bottomSheetHeight = heightFactor != null
            ? screenHeight * heightFactor
            : screenHeight / 2;

        return SizedBox(
          height: bottomSheetHeight,
          child: DefaultTabController(
            length: tabBarViews.length,
            initialIndex: initialTabIndex,
            child: Column(
              children: [
                // TabBar(
                //   tabs: List.generate(
                //     tabBarViews.length,
                //     (index) => Tab(text: 'Tab ${index + 1}'),
                //   ),
                // ),
                const TabBar(
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

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
