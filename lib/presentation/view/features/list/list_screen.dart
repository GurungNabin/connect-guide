import 'package:connect_me_app/data/busniness_data.dart';
import 'package:connect_me_app/model/business/business_model.dart';
import 'package:connect_me_app/presentation/view/common/custom_card_list.dart';
import 'package:connect_me_app/presentation/view/common/details.dart';
import 'package:connect_me_app/presentation/view/common/overview.dart';
import 'package:connect_me_app/presentation/view/common/rating&review.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, this.selectedBusiness});

  final Result? selectedBusiness;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<Result>> futureBusinessData;
  List<Result> allBusinesses = [];
  List<Result> filteredBusinesses = [];
  String searchText = "";
  String selectedCategory = "All";
  int favoriteCount = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   futureBusinessData = BusinessService().fetchBusinessData();
  //   futureBusinessData.then((data) {
  //     setState(() {
  //       allBusinesses = data.results;
  //       filteredBusinesses = _applyFilters(allBusinesses);
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    futureBusinessData = BusinessService().fetchBusinessData();
    futureBusinessData.then((data) {
      setState(() {
        allBusinesses = data;
        if (widget.selectedBusiness != null) {
          filteredBusinesses = [widget.selectedBusiness!];
        } else {
          filteredBusinesses = _applyFilters(allBusinesses);
        }
      });
    });
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

  Future<void> _updateFavoriteCount() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    setState(() {
      favoriteCount = keys.length;
    });
  }

  void _onFavoriteStatusChanged() {
    _updateFavoriteCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                    _filterBusinesses(); // Apply search filter
                  });
                },
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCategoryTab("All",
                        isSelected: selectedCategory == "All"),
                    _buildCategoryTab("College",
                        isSelected: selectedCategory == "College"),
                    _buildCategoryTab("Hospital",
                        isSelected: selectedCategory == "Hospital"),
                    _buildCategoryTab("Restaurant",
                        isSelected: selectedCategory == "Restaurant"),
                    _buildCategoryTab("Hotel",
                        isSelected: selectedCategory == "Hotel"),
                    _buildCategoryTab("Cafe",
                        isSelected: selectedCategory == "Cafe"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Result>>(
                  future: futureBusinessData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: filteredBusinesses.length,
                        itemBuilder: (BuildContext context, int index) {
                          final business = filteredBusinesses[index];
                          return CustomInfoCardList(
                            title: business.category ?? 'No category',
                            name: business.name ?? 'No name',
                            address:
                                business.location?.toString() ?? 'No address',
                            distance: '3.1 km away',
                            time: '10 am - 5 pm',
                            rating: business.rating,
                            imageUrl: (business.photos != null &&
                                    business.photos!.isNotEmpty)
                                ? business.photos![
                                    0] // Safe access to the first photo
                                : null, // Default to null if photos is null or empty
                            onTap: () {
                              showCustomBottomSheet(
                                context: context,
                                initialTabIndex: 0,
                                heightFactor: 0.8,
                                tabBarViews: [
                                  OverView(
                                    business: business,
                                    onFavoriteStatusChanged:
                                        _onFavoriteStatusChanged,
                                  ),
                                  RatingAndReviewTab(
                                    reviews: business.reviews ?? [],
                                  ),
                                  Details(
                                    business: business,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String category, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedCategory = category;
            _filterBusinesses(); // Apply category filter
          });
        },
      ),
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

        return Container(
          height: bottomSheetHeight,
          padding: MediaQuery.of(context).viewInsets,
          child: DefaultTabController(
            length: 3,
            initialIndex: initialTabIndex,
            child: Column(
              children: <Widget>[
                const TabBar(
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
