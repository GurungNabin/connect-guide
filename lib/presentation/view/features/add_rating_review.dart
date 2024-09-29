import 'package:connect_me_app/model/business/business_model.dart';
import 'package:flutter/material.dart';

class AddRatingAndReviewTab extends StatefulWidget {
  final List<Review> reviews;

  const AddRatingAndReviewTab({
    super.key,
    required this.reviews,
  });

  @override
  _AddRatingAndReviewTabState createState() => _AddRatingAndReviewTabState();
}

class _AddRatingAndReviewTabState extends State<AddRatingAndReviewTab> {
  double _selectedRating = 0.0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Calculate the average rating
    double averageRating = widget.reviews.isNotEmpty
        ? widget.reviews
                .map((review) => review.rating ?? 0.0)
                .reduce((a, b) => a + b) /
            widget.reviews.length
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Rating and Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Add Rating and Review',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Rate Section
            const Text(
              'Rate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedRating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 16),

            // Full Name TextField
            const Text(
              'Full Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Review TextField
            const Text(
              'Review',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Review',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add review logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(120, 94, 246, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
