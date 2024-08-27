import 'dart:convert';

import 'package:connect_me_app/model/business/business_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OverView extends StatefulWidget {
  final Result business;
  final VoidCallback onFavoriteStatusChanged;

  const OverView({
    super.key,
    required this.business,
    required this.onFavoriteStatusChanged,
  });

  @override
  _OverViewState createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the value from SharedPreferences
    final storedValue = prefs.get(widget.business.name ?? '');

    // Safely cast the value to bool
    if (storedValue is bool) {
      setState(() {
        isFavorite = storedValue;
      });
    } else {
      setState(() {
        isFavorite = false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        final data = {
          'title': widget.business.category ?? 'No category',
          'name': widget.business.name ?? 'No name',
          'address': widget.business.location?.toString() ?? 'No address',
          'distance': '3.1 km away',
          'time': '10 am - 5 pm',
          'rating': widget.business.rating,
        };
        prefs.setString(widget.business.name ?? '', json.encode(data));
      } else {
        prefs.remove(widget.business.name ?? '');
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(isFavorite ? 'Added to Favorites' : 'Removed from Favorites'),
      ),
    );

    widget.onFavoriteStatusChanged();
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final photos = widget.business.photos ?? [];
    final photoWidgets = photos.isNotEmpty
        ? photos
            .map((photoUrl) => Image.network(
                  photoUrl,
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 100),
                ))
            .toList()
        : [
            Image.network('https://via.placeholder.com/100',
                width: 100, height: 100)
          ];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                            widget.business.category.toString(),
                            style: TextStyle(
                              color: Colors.purple.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          widget.business.name.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          widget.business.location ?? 'No Address',
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
                            const Expanded(
                              child: Text(
                                '3.1 km away',
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
                            const Expanded(
                              child: Text(
                                '10 am - 5 pm',
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
                                widget.business.rating.toString(),
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
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            final phoneNumber = widget.business.contact;
                            if (phoneNumber != null && phoneNumber.isNotEmpty) {
                              _launchURL(context, 'tel:$phoneNumber');
                            }
                          },
                          icon: const Icon(Icons.call, size: 16),
                          label: const Text("Call",
                              style: TextStyle(fontSize: 12)),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            final siteUrl = widget.business.website;
                            if (siteUrl != null && siteUrl.isNotEmpty) {
                              final validUrl = siteUrl.startsWith('http')
                                  ? siteUrl
                                  : 'http://$siteUrl';
                              _launchURL(context, validUrl);
                            }
                          },
                          icon: const Icon(Icons.web, size: 16),
                          label: const Text("Website",
                              style: TextStyle(fontSize: 12)),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            final location = widget.business.location;
                            if (location != null) {
                              final encodedLocation =
                                  Uri.encodeComponent(location.toString());
                              _launchURL(context,
                                  'https://www.google.com/maps/search/?api=1&query=$encodedLocation');
                            }
                          },
                          icon: const Icon(Icons.map, size: 16),
                          label:
                              const Text("Map", style: TextStyle(fontSize: 12)),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            final emailAddress = widget.business.email;
                            if (emailAddress != null &&
                                emailAddress.isNotEmpty) {
                              _launchURL(context, 'mailto:$emailAddress');
                            }
                          },
                          icon: const Icon(Icons.email, size: 16),
                          label: const Text("Email",
                              style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Images',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: photoWidgets.length,
                      itemBuilder: (context, index) => photoWidgets[index],
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Notes',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'This contact address was given by Surya for me to setup a meeting with this college.',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            'Social Links:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon:
                                const Icon(Icons.facebook, color: Colors.blue),
                            onPressed: () {
                              _launchURL(context, 'https://www.facebook.com/');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt,
                                color: Colors.purple),
                            onPressed: () {
                              _launchURL(context, 'https://www.instagram.com/');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.alternate_email,
                                color: Colors.blue),
                            onPressed: () {
                              _launchURL(context, 'mailto:example@example.com');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: _toggleFavorite,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                  ),
                  Text(
                    isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
