import 'package:flutter/material.dart';

class RatingAndReviewTab extends StatelessWidget {
  final List<Review> reviews = [
    Review(
      name: "Ram Shrestha",
      rating: 3.0,
      review:
          "COVID-19 affects different people in different ways. Most infected people will develop mild to different ways. Most infected people will develop mild to",
      time: "4 min",
      avatarUrl: "https://randomuser.me/api/portraits/women/1.jpg",
    ),
    Review(
      name: "Hari Sharma",
      rating: 4.0,
      review:
          "COVID-19 affects different people in different ways. Most infected people will develop mild to different ways. Most infected people will develop mild to",
      time: "4 min",
      avatarUrl: "https://randomuser.me/api/portraits/men/1.jpg",
    ),
    Review(
      name: "Hari Sharma",
      rating: 2.0,
      review:
          "COVID-19 affects different people in different ways. Most infected people will develop mild to different ways. Most infected people will develop mild to",
      time: "4 min",
      avatarUrl: "https://randomuser.me/api/portraits/men/2.jpg",
    ),
      Review(
      name: "Hari Sharma",
      rating: 2.0,
      review:
          "COVID-19 affects different people in different ways. Most infected people will develop mild to different ways. Most infected people will develop mild to",
      time: "4 min",
      avatarUrl: "https://randomuser.me/api/portraits/men/2.jpg",
    ),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating Summary
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(120, 94, 246, 450), borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            '3.1 Rating',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < 3 ? Icons.star : Icons.star_border,
                              color: Colors.purple,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '13 Reviews',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Reviews',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16),

          // Review List
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ReviewTile(review: reviews[index]);
              },
            ),
          ),

          // Add Review Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(120, 94, 246, 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Center(
              child: Text(
                'Add Rate and Review',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Review {
  final String name;
  final double rating;
  final String review;
  final String time;
  final String avatarUrl;

  Review({
    required this.name,
    required this.rating,
    required this.review,
    required this.time,
    required this.avatarUrl,
  });
}

class ReviewTile extends StatelessWidget {
  final Review review;

  ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(review.avatarUrl),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        review.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < review.rating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.purple,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  review.review,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(height: 4),
                Text(
                  review.time,
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
