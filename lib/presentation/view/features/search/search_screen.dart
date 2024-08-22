import 'package:connect_me_app/data/busniness_data.dart';
import 'package:connect_me_app/model/business/business_model.dart';
import 'package:flutter/material.dart';

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

  final categories = [
    'IT Companies',
    'Cafe',
    'Hotel',
    'Hospital',
    'College',
    'School',
    'Government offices',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search businesses near you',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                ),
                const SizedBox(height: 20),
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
                    final isSelected = selectedCategories.contains(category);
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
                    backgroundColor: Colors.purple,
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
                  Expanded(
                    child: ListView.builder(
                      
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final business = searchResults[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: ListTile(
                            leading: business.photos != null &&
                                    business.photos!.isNotEmpty
                                ? Image.network(
                                    business.photos![0],
                                    width: 50,
                                    height: 50,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  )
                                : const Icon(Icons.business),
                            title: Text(business.name ?? "No Name"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(business.category ?? "No Category"),
                                const SizedBox(height: 5),
                                Text("Location: ${business.location}"),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.yellow[700]),
                                Text(business.rating),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    ValueChanged<double> onChanged, {
    double max = 100,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Slider(
                value: value,
                min: 0,
                max: max,
                onChanged: onChanged,
              ),
            ),
            Text(
                '${value.toStringAsFixed(1)} ${label.contains('Rating') ? '' : 'km'}'),
          ],
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
          searchResults = businessModel.results;
        });
      } else {
        // Apply filters
        final filteredResults = businessModel.results.where((business) {
          final matchesRating =
              double.tryParse(business.rating ?? '0')! >= _rating;
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
}
