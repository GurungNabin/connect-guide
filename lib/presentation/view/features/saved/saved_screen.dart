import 'dart:convert';

import 'package:connect_me_app/presentation/view/common/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    setState(() {
      _favorites = keys.toList();
    });
  }

  Future<void> _removeFavorite(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(name);
    _loadFavorites(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorites'),
      ),
      body: SafeArea(
        child: _favorites.isEmpty
            ? const Center(child: Text('No favorites saved.'))
            : ListView.builder(
                itemCount: _favorites.length,
                itemBuilder: (context, index) {
                  final name = _favorites[index];
                  return FutureBuilder<Map<String, dynamic>>(
                    future: _getFavoriteData(name),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error loading data'));
                      } else if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return Stack(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(8.0),
                              title: CustomInfoCard(
                                title: data['title'] ?? 'No category',
                                name: data['name'] ?? 'No name',
                                address: data['address'] ?? 'No address',
                                distance: data['distance'] ?? 'Unknown',
                                time: data['time'] ?? 'Unknown',
                                rating: data['rating'] ?? '0',
                                onTap: () {
                                  // Handle tap event
                                },
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10, // Adjusted position to be visible
                              child: IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () {
                                  _removeFavorite(name);
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(child: Text('No data available'));
                      }
                    },
                  );
                },
              ),
      ),
    );
  }

  Future<Map<String, dynamic>> _getFavoriteData(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(name);
    if (data != null) {
      return Map<String, dynamic>.from(json.decode(data));
    }
    return {};
  }
}

// import 'package:connect_me_app/data/busniness_data.dart';
// import 'package:connect_me_app/model/business/business_model.dart';
// import 'package:flutter/material.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   double _locationRadius = 0;
//   double _rating = 0;
//   List<String> selectedCategories = [];
//   String hashtag = '';
//   List<Result> searchResults = [];

//   final categories = [
//     'IT Companies',
//     'Cafe',
//     'Hotel',
//     'Hospital',
//     'College',
//     'School',
//     'Government offices',
//   ];

//   Future<void> _searchBusinesses() async {
//     try {
//       final businessService = BusinessService();
//       final businessModel = await businessService.fetchBusinessData();

//       // Filter results based on search criteria
//       final filteredResults = businessModel.results.where((business) {
//         final matchesRating = double.parse(business.rating) >= _rating;
//         final matchesCategory = selectedCategories.isEmpty ||
//             (business.category != null &&
//                 selectedCategories.contains(business.category));
//         final matchesHashtag = hashtag.isEmpty ||
//             (business.name != null && business.name!.contains(hashtag));

//         return matchesRating && matchesCategory && matchesHashtag;
//       }).toList();

//       setState(() {
//         searchResults = filteredResults;
//       });
//     } catch (e) {
//       print('Error: $e');
//       // Handle errors appropriately in your UI
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Businesses'),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Search businesses near you',
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22,
//                     ),
//               ),
//               const SizedBox(height: 20),
//               _buildSlider(
//                 'Location Radius (km)',
//                 _locationRadius,
//                 (value) {
//                   setState(() {
//                     _locationRadius = value;
//                   });
//                 },
//               ),
//               _buildSlider(
//                 'Rating',
//                 _rating,
//                 (value) {
//                   setState(() {
//                     _rating = value;
//                   });
//                 },
//                 max: 5,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Categories',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               Wrap(
//                 spacing: 8.0,
//                 children: categories.map((category) {
//                   final isSelected = selectedCategories.contains(category);
//                   return FilterChip(
//                     label: Text(category),
//                     selected: isSelected,
//                     onSelected: (selected) {
//                       setState(() {
//                         isSelected
//                             ? selectedCategories.remove(category)
//                             : selectedCategories.add(category);
//                       });
//                     },
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Hashtag',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'e.g., #Schools',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     hashtag = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _searchBusinesses,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   backgroundColor: Colors.purple,
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.search,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       'Search',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: searchResults.length,
//                   itemBuilder: (context, index) {
//                     final business = searchResults[index];
//                     return Card(
//                       margin: const EdgeInsets.only(bottom: 16.0),
//                       child: ListTile(
//                         leading: business.photos != null &&
//                                 business.photos!.isNotEmpty
//                             ? Image.network(
//                                 business.photos![
//                                     0], // Assuming the first photo URL is used
//                                 width: 50,
//                                 height: 50,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return const Icon(Icons.error);
//                                 },
//                               )
//                             : const Icon(Icons.business),
//                         title: Text(business.name ?? "No Name"),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(business.category ?? "No Category"),
//                             const SizedBox(height: 5),
//                             Text("Location: ${business.location}"),
//                           ],
//                         ),
//                         trailing: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.star, color: Colors.yellow[700]),
//                             Text(business.rating),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSlider(
//       String label, double value, ValueChanged<double> onChanged,
//       {double max = 100}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: Theme.of(context).textTheme.bodyMedium),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Slider(
//                 value: value,
//                 min: 0,
//                 max: max,
//                 onChanged: onChanged,
//               ),
//             ),
//             Text(
//                 '${value.toStringAsFixed(1)} ${label.contains('Rating') ? '' : 'km'}'),
//           ],
//         ),
//       ],
//     );
//   }
// }
