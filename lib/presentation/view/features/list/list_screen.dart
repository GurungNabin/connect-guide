import 'package:connect_me_app/data/busniness_data.dart';
import 'package:connect_me_app/model/business/business_model.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<BusinessModel> futureBusinessData;
  List<Result> filteredBusinesses = [];
  String searchText = "";
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    futureBusinessData = BusinessService().fetchBusinessData();
    futureBusinessData.then((data) {
      setState(() {
        // Initialize the filtered list with all results when data is first loaded
        filteredBusinesses = data.results;
      });
    });
  }

  void _filterBusinesses(String searchText, String category) {
    setState(() {
      filteredBusinesses = filteredBusinesses.where((business) {
        final matchesSearchText = business.name != null &&
            business.name!.toLowerCase().contains(searchText.toLowerCase());
        final matchesCategory = category == "All" ||
            (business.category != null &&
                business.category!.toLowerCase() == category.toLowerCase());
        return matchesSearchText && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Near You'),
        elevation: 0,
      ),
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
                  });
                  _filterBusinesses(searchText, selectedCategory);
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
                child: FutureBuilder<BusinessModel>(
                  future: futureBusinessData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      // No need to call _filterBusinesses here; it is handled during data load and user interaction
                      return ListView.builder(
                        itemCount: filteredBusinesses.length,
                        itemBuilder: (context, index) {
                          final business = filteredBusinesses[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            child: ListTile(
                              leading: business.photos != null &&
                                      business.photos!.isNotEmpty
                                  ? Image.network(
                                      business.photos![0],
                                      width: 50,
                                      height: 50,
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
            _filterBusinesses(searchText, selectedCategory);
          });
        },
      ),
    );
  }
}
