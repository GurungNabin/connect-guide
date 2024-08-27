
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomInfoCardList extends StatelessWidget {
  final String title;
  final String name;
  final String address;
  final String distance;
  final String time;
  final String rating;
  final String? imageUrl;
  final Function() onTap;

  const CustomInfoCardList({
    super.key,
    required this.title,
    required this.name,
    required this.address,
    required this.distance,
    required this.time,
    required this.rating,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 300.0,
        height: 200.0,
        child: Card(
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          child: Row(
            children: [
              // Text Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F0FD),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.purple.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[700],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.directions_walk,
                              size: 16.0,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              distance,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 16.0,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              time,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.star,
                              size: 16.0,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              rating.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Image or Placeholder
              Container(
                width: 100.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0),
                  ),
                ),
                child: imageUrl != null &&
                        Uri.tryParse(imageUrl!)?.isAbsolute == true
                    ? CachedNetworkImage(
                        imageUrl: imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.white, // Background color while loading
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.white, // Background color for errors
                          child: const Image(
                            image: AssetImage('assets/images/company.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        color: Colors
                            .white, // Background color for the fallback image
                        child: const Image(
                          image: AssetImage('assets/images/company.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
