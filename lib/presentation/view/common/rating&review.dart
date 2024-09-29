// import 'package:connect_me_app/model/business/business_model.dart';
// import 'package:connect_me_app/presentation/view/features/add_rating_review.dart';
// import 'package:flutter/material.dart';

// class RatingAndReviewTab extends StatelessWidget {
//   final List<Review> reviews;

//   const RatingAndReviewTab({
//     super.key,
//     required this.reviews,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Calculate the average rating
//     double averageRating = reviews.isNotEmpty
//         ? reviews
//                 .map((review) => review.rating ?? 0.0)
//                 .reduce((a, b) => a + b) /
//             reviews.length
//         : 0.0;

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Rating Summary
//           Container(
//             decoration: BoxDecoration(
//               color: const Color.fromRGBO(120, 94, 246, 0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${averageRating.toStringAsFixed(1)} Rating',
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Row(
//                           children: List.generate(5, (index) {
//                             return Icon(
//                               index < averageRating.floor()
//                                   ? Icons.star
//                                   : Icons.star_border,
//                               color: Colors.purple,
//                             );
//                           }),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '${reviews.length} Reviews',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           const Text(
//             'Reviews',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 16),

//           // Review List
//           Expanded(
//             child: ListView.builder(
//               itemCount: reviews.length,
//               itemBuilder: (context, index) {
//                 return ReviewTile(review: reviews[index]);
//               },
//             ),
//           ),

//           // Add Review Button
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return const AddRatingAndReviewTab(
//                   reviews: [],
//                 );
//               }));
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color.fromRGBO(120, 94, 246, 1.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//             ),
//             child: const Center(
//               child: Text(
//                 'Add Rate and Review',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ReviewTile extends StatelessWidget {
//   final Review review;

//   const ReviewTile({super.key, required this.review});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CircleAvatar(
//             radius: 24,
//             backgroundImage: NetworkImage('https://via.placeholder.com/150'),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         review.name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: List.generate(5, (index) {
//                         return Icon(
//                           index < (review.rating ?? 0.0).floor()
//                               ? Icons.star
//                               : Icons.star_border,
//                           color: Colors.purple,
//                           size: 16,
//                         );
//                       }),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   review.comment ?? 'No comment',
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Colors.black87),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   review.charges ?? 'No time info',
//                   style: TextStyle(color: Colors.grey.shade500),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// second snippet with add rating and review bottom sheet

// import 'package:connect_me_app/model/business/business_model.dart';
// import 'package:flutter/material.dart';

// class RatingAndReviewTab extends StatelessWidget {
//   final List<Review> reviews;

//   const RatingAndReviewTab({
//     super.key,
//     required this.reviews,
//   });

//   void _showAddRatingReviewSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: AddRatingReviewContent(
//             selectedRating: 0.0,
//             nameController: TextEditingController(),
//             reviewController: TextEditingController(),
//             onRatingChanged: (rating) {
//               // Handle rating change
//             },
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Calculate the average rating
//     double averageRating = reviews.isNotEmpty
//         ? reviews
//                 .map((review) => review.rating ?? 0.0)
//                 .reduce((a, b) => a + b) /
//             reviews.length
//         : 0.0;

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Rating Summary
//           Container(
//             decoration: BoxDecoration(
//               color: const Color.fromRGBO(120, 94, 246, 0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${averageRating.toStringAsFixed(1)} Rating',
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Row(
//                           children: List.generate(5, (index) {
//                             return Icon(
//                               index < averageRating.floor()
//                                   ? Icons.star
//                                   : Icons.star_border,
//                               color: Colors.purple,
//                             );
//                           }),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '${reviews.length} Reviews',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           const Text(
//             'Reviews',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 16),

//           // Review List
//           Expanded(
//             child: ListView.builder(
//               itemCount: reviews.length,
//               itemBuilder: (context, index) {
//                 return ReviewTile(review: reviews[index]);
//               },
//             ),
//           ),

//           // Add Review Button
//           ElevatedButton(
//             onPressed: () => _showAddRatingReviewSheet(context),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color.fromRGBO(120, 94, 246, 1.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//             ),
//             child: const Center(
//               child: Text(
//                 'Add Rate and Review',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ReviewTile extends StatelessWidget {
//   final Review review;

//   const ReviewTile({super.key, required this.review});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CircleAvatar(
//             radius: 24,
//             backgroundImage: NetworkImage('https://via.placeholder.com/150'),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         review.name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: List.generate(5, (index) {
//                         return Icon(
//                           index < (review.rating ?? 0.0).floor()
//                               ? Icons.star
//                               : Icons.star_border,
//                           color: Colors.purple,
//                           size: 16,
//                         );
//                       }),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   review.comment ?? 'No comment',
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Colors.black87),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   review.charges ?? 'No time info',
//                   style: TextStyle(color: Colors.grey.shade500),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AddRatingReviewContent extends StatelessWidget {
//   final double selectedRating;
//   final TextEditingController nameController;
//   final TextEditingController reviewController;
//   final ValueChanged<double> onRatingChanged;

//   const AddRatingReviewContent({
//     super.key,
//     required this.selectedRating,
//     required this.nameController,
//     required this.reviewController,
//     required this.onRatingChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Title
//           const Text(
//             'Add Rating and Review',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           // Rate Section
//           const Text(
//             'Rate',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//           Row(
//             children: List.generate(5, (index) {
//               return IconButton(
//                 icon: Icon(
//                   index < selectedRating ? Icons.star : Icons.star_border,
//                   color: Colors.purple,
//                 ),
//                 onPressed: () {
//                   onRatingChanged(index + 1.0);
//                 },
//               );
//             }),
//           ),
//           const SizedBox(height: 16),

//           // Full Name TextField
//           const Text(
//             'Full Name',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//           TextField(
//             controller: nameController,
//             decoration: const InputDecoration(
//               labelText: 'Full Name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Review TextField
//           const Text(
//             'Review',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//           TextField(
//             controller: reviewController,
//             decoration: const InputDecoration(
//               labelText: 'Review',
//               border: OutlineInputBorder(),
//             ),
//             maxLines: 3,
//           ),
//           const SizedBox(height: 16),

//           // Buttons
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.grey,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                 ),
//                 child: const Text(
//                   'Cancel',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Add review logic here
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromRGBO(120, 94, 246, 1.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                 ),
//                 child: const Text(
//                   'Add',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:connect_me_app/model/business/business_model.dart';
import 'package:flutter/material.dart';

class RatingAndReviewTab extends StatefulWidget {
  final List<Review> reviews;

  const RatingAndReviewTab({
    super.key,
    required this.reviews,
  });

  @override
  _RatingAndReviewTabState createState() => _RatingAndReviewTabState();
}

class _RatingAndReviewTabState extends State<RatingAndReviewTab> {
  void _showAddRatingReviewSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddRatingReviewContent(
            // selectedRating: 0.0,
            nameController: TextEditingController(),
            reviewController: TextEditingController(),
            // onRatingChanged: (rating) {
            //   // Handle rating change
            // },
            onAddReview: (review) {
              setState(() {
                widget.reviews.add(review);
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the average rating
    double averageRating = widget.reviews.isNotEmpty
        ? widget.reviews
                .map((review) => review.rating ?? 0.0)
                .reduce((a, b) => a + b) /
            widget.reviews.length
        : 0.0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating Summary
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(120, 94, 246, 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${averageRating.toStringAsFixed(1)} Rating',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < averageRating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.purple,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '${widget.reviews.length} Reviews',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Reviews',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),

          // Review List
          Expanded(
            child: ListView.builder(
              itemCount: widget.reviews.length,
              itemBuilder: (context, index) {
                return ReviewTile(review: widget.reviews[index]);
              },
            ),
          ),

          // Add Review Button
          ElevatedButton(
            onPressed: () => _showAddRatingReviewSheet(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(120, 94, 246, 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Center(
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

class ReviewTile extends StatelessWidget {
  final Review review;

  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        review.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (review.rating ?? 0.0).floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.purple,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  review.comment ?? 'No comment',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  review.charges ?? 'No time info',
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

class AddRatingReviewContent extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController reviewController;
  final ValueChanged<Review> onAddReview;

  const AddRatingReviewContent({
    super.key,
    required this.nameController,
    required this.reviewController,
    required this.onAddReview,
  });

  @override
  _AddRatingReviewContentState createState() => _AddRatingReviewContentState();
}

class _AddRatingReviewContentState extends State<AddRatingReviewContent> {
  double selectedRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
                  index < selectedRating ? Icons.star : Icons.star_border,
                  color: Colors.purple,
                ),
                onPressed: () {
                  setState(() {
                    selectedRating = index + 1.0;
                  });
                  print('Star ${index + 1} tapped'); // Debugging statement
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
            controller: widget.nameController,
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
            controller: widget.reviewController,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                  final newReview = Review(
                    id: '',
                    name: widget.nameController.text,
                    rating: selectedRating,
                    comment: widget.reviewController.text,
                    charges: 'Just now', // You can update this as needed
                  );
                  widget.onAddReview(newReview);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(120, 94, 246, 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
    );
  }
}
