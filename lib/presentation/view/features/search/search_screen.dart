import 'package:connect_me_app/core/ui/main_theme.dart';
import 'package:connect_me_app/data/busniness_data.dart';
import 'package:connect_me_app/model/business/business_model.dart';
import 'package:connect_me_app/presentation/view/common/custom_card.dart';
import 'package:connect_me_app/presentation/view/common/details.dart';
import 'package:connect_me_app/presentation/view/common/overview.dart';
import 'package:connect_me_app/presentation/view/common/rating&review.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  double _locationRadius = 0;
  double _rating = 0;
  List<String> selectedCategories = [];
  List<Result> searchResults = [];
  bool isLoading = false;
  bool hasError = false;
  int favoriteCount = 0;

  final categories = [
    'IT Companies',
    'Cafe',
    'Hotel',
    'Hospital',
    'College',
    'School',
    'Government offices',
  ];

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Search businesses near you',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSlider(
                        'Location Radius (km)',
                        _locationRadius,
                        (value) {
                          setState(() {
                            _locationRadius = value;
                          });
                        },
                      ),
                      _buildSlider(
                        'Rating',
                        _rating,
                        (value) {
                          setState(() {
                            _rating = value;
                          });
                        },
                        max: 5,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Categories',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: categories.map((category) {
                          final isSelected =
                              selectedCategories.contains(category);
                          return FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                isSelected
                                    ? selectedCategories.remove(category)
                                    : selectedCategories.add(category);
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Hashtag',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: 'eg. #Schools',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _searchBusinesses,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: ThemeConfig.theme.primaryColor,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Search',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (isLoading) ...[
                        const Center(child: CircularProgressIndicator()),
                      ] else if (hasError) ...[
                        const Center(child: Text('Error loading data.')),
                      ] else if (searchResults.isEmpty) ...[
                        const Center(child: Text('No businesses found.')),
                      ] else ...[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // scrollDirection: Axis.vertical,
                          itemCount: searchResults.length,
                          itemBuilder: (BuildContext context, int index) {
                            final business = searchResults[index];
                            return CustomInfoCard(
                              title: business.category ?? 'No category',
                              name: business.name ?? 'No name',
                              address:
                                  business.location?.toString() ?? 'No address',
                              distance: '3.1 km away',
                              time: '10 am - 5 pm',
                              rating: business.rating,
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
                                      // reviews: business.reviews ?? [],
                                      // Line 191
                                      reviews: business.reviews?.cast() ?? [],
                                    ),
                                    Details(
                                      business: business,
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    ValueChanged<double> onChanged, {
    double max = 10,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium!),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F0FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                  '${value.toStringAsFixed(1)} ${label.contains('Rating') ? '' : 'km'}'),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFF785ef6),
            inactiveTrackColor: const Color(0xFF785ef6).withOpacity(0.2),
            thumbColor: const Color(0xFF785ef6),
            overlayColor: const Color(0xFF785ef6).withAlpha(32),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Future<void> _searchBusinesses() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final businessService = BusinessService();
      final businessModel = await businessService.fetchBusinessData();

      // Check if location, rating are both 0, and no categories selected
      if (_locationRadius == 0 && _rating == 0 && selectedCategories.isEmpty) {
        // No filters applied, show all businesses
        setState(() {
          searchResults = businessModel;
        });
      } else {
        // Apply filters
        final filteredResults = businessModel.where((business) {
          final matchesRating = double.tryParse(business.rating)! >= _rating;
          final matchesCategory = selectedCategories.isEmpty ||
              (business.category != null &&
                  selectedCategories.contains(business.category));
          final matchesLocationRadius = _locationRadius == 0 ||
              true; // Assuming location logic is applied here

          return matchesRating && matchesCategory && matchesLocationRadius;
        }).toList();

        setState(() {
          searchResults = filteredResults;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
