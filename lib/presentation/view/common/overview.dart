// import 'dart:convert';

// import 'package:connect_me_app/model/business/business_model.dart';
// import 'package:connect_me_app/presentation/view/common/custom_card.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class OverView extends StatefulWidget {
//   final Result business;
//   final VoidCallback onFavoriteStatusChanged;

//   const OverView({
//     super.key,
//     required this.business,
//     required this.onFavoriteStatusChanged,
//   });

//   @override
//   _OverViewState createState() => _OverViewState();
// }

// class _OverViewState extends State<OverView> {
//   bool isFavorite = false; // Initialize with default value

//   @override
//   void initState() {
//     super.initState();
//     _loadFavoriteStatus();
//   }

//   // Future<void> _loadFavoriteStatus() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   setState(() {
//   //     isFavorite = prefs.getBool(widget.business.name ?? '') ?? false;
//   //   });
//   // }

//   // Future<void> _toggleFavorite() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   setState(() {
//   //     isFavorite = !isFavorite;
//   //     if (isFavorite) {
//   //       final data = {
//   //         'title': widget.business.category ?? 'No category',
//   //         'name': widget.business.name ?? 'No name',
//   //         'address': widget.business.location?.toString() ?? 'No address',
//   //         'distance': '3.1 km away',
//   //         'time': '10 am - 5 pm',
//   //         'rating': widget.business.rating,
//   //       };
//   //       prefs.setString(widget.business.name ?? '', json.encode(data));
//   //     } else {
//   //       prefs.remove(widget.business.name ?? '');
//   //     }
//   //   });

//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       content:
//   //           Text(isFavorite ? 'Added to Favorites' : 'Removed from Favorites'),
//   //     ),
//   //   );
//   // }

//   Future<void> _loadFavoriteStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isFavorite = prefs.getBool(widget.business.name ?? '') ?? false;
//     });
//   }

//   Future<void> _toggleFavorite() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isFavorite = !isFavorite;
//       if (isFavorite) {
//         final data = {
//           'title': widget.business.category ?? 'No category',
//           'name': widget.business.name ?? 'No name',
//           'address': widget.business.location?.toString() ?? 'No address',
//           'distance': '3.1 km away',
//           'time': '10 am - 5 pm',
//           'rating': widget.business.rating,
//         };
//         prefs.setString(widget.business.name ?? '', json.encode(data));
//       } else {
//         prefs.remove(widget.business.name ?? '');
//       }
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content:
//             Text(isFavorite ? 'Added to Favorites' : 'Removed from Favorites'),
//       ),
//     );

//     // Notify the parent widget that the favorite status has changed
//     widget.onFavoriteStatusChanged();
//   }

//   Future<void> _launchURL(BuildContext context, String url) async {
//     final Uri uri = Uri.parse(url);
//     try {
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri);
//       } else {
//         throw 'Could not launch $url';
//       }
//     } catch (e) {
//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not open the URL')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final photos = widget.business.photos ?? [];
//     final photoWidgets = photos.isNotEmpty
//         ? photos
//             .map((photoUrl) => Image.network(
//                   photoUrl,
//                   width: 100,
//                   height: 100,
//                   errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.error, size: 100),
//                 ))
//             .toList()
//         : [
//             Image.network('https://via.placeholder.com/100',
//                 width: 100, height: 100)
//           ];

//     return Column(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CustomInfoCard(
//                   title: widget.business.category ?? 'No category',
//                   name: widget.business.name ?? 'No name',
//                   address: widget.business.location?.toString() ?? 'No address',
//                   distance: '3.1 km away',
//                   time: '10 am - 5 pm',
//                   rating: widget.business.rating,
//                   onTap: () {},
//                 ),
//                 const SizedBox(height: 15),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             final phoneNumber = widget.business.contact;
//                             if (phoneNumber != null && phoneNumber.isNotEmpty) {
//                               _launchURL(context, 'tel:$phoneNumber');
//                             }
//                           },
//                           icon: const Icon(Icons.call, size: 16),
//                           label: const Text("Call",
//                               style: TextStyle(fontSize: 12)),
//                         ),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             final siteUrl = widget.business.website;
//                             if (siteUrl != null && siteUrl.isNotEmpty) {
//                               final validUrl = siteUrl.startsWith('http')
//                                   ? siteUrl
//                                   : 'http://$siteUrl';
//                               _launchURL(context, validUrl);
//                             }
//                           },
//                           icon: const Icon(Icons.web, size: 16),
//                           label: const Text("Website",
//                               style: TextStyle(fontSize: 12)),
//                         ),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             final location = widget.business.location;
//                             if (location != null) {
//                               final encodedLocation =
//                                   Uri.encodeComponent(location.toString());
//                               _launchURL(context,
//                                   'https://www.google.com/maps/search/?api=1&query=$encodedLocation');
//                             }
//                           },
//                           icon: const Icon(Icons.map, size: 16),
//                           label:
//                               const Text("Map", style: TextStyle(fontSize: 12)),
//                         ),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             final emailAddress = widget.business.email;
//                             if (emailAddress != null &&
//                                 emailAddress.isNotEmpty) {
//                               _launchURL(context, 'mailto:$emailAddress');
//                             }
//                           },
//                           icon: const Icon(Icons.email, size: 16),
//                           label: const Text("Email",
//                               style: TextStyle(fontSize: 12)),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Images',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     GridView.builder(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       shrinkWrap: true,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 8,
//                         mainAxisSpacing: 8,
//                       ),
//                       itemCount: photoWidgets.length,
//                       itemBuilder: (context, index) => photoWidgets[index],
//                     ),
//                     const SizedBox(height: 8),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Notes',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'This contact address was given by Surya for me to setup a meeting with this college.',
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           const Text(
//                             'Social Links:',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           IconButton(
//                             icon:
//                                 const Icon(Icons.facebook, color: Colors.blue),
//                             onPressed: () {
//                               _launchURL(context, 'https://www.facebook.com/');
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.camera_alt,
//                                 color: Colors.purple),
//                             onPressed: () {
//                               _launchURL(context, 'https://www.instagram.com/');
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.alternate_email,
//                                 color: Colors.blue),
//                             onPressed: () {
//                               _launchURL(context, 'mailto:example@example.com');
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: _toggleFavorite,
//             child: Container(
//               width: double.infinity,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.purpleAccent,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
//                     style: const TextStyle(fontSize: 20, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'dart:convert';

// import 'package:connect_me_app/model/business/business_model.dart';
// import 'package:connect_me_app/presentation/view/common/custom_card.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class OverView extends StatefulWidget {
//   final Result business;
//   final VoidCallback onFavoriteStatusChanged;

//   const OverView({
//     super.key,
//     required this.business,
//     required this.onFavoriteStatusChanged,
//   });

//   @override
//   _OverViewState createState() => _OverViewState();
// }

// class _OverViewState extends State<OverView> {
//   bool isFavorite = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadFavoriteStatus();
//   }

//   Future<void> _loadFavoriteStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     final status = prefs.getBool(widget.business.name ?? '') ?? false;
//     setState(() {
//       isFavorite = status;
//     });
//   }

//   Future<void> _toggleFavorite() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isFavorite = !isFavorite;
//       if (isFavorite) {
//         final data = {
//           'title': widget.business.category ?? 'No category',
//           'name': widget.business.name ?? 'No name',
//           'address': widget.business.location?.toString() ?? 'No address',
//           'distance': '3.1 km away',
//           'time': '10 am - 5 pm',
//           'rating': widget.business.rating,
//         };
//         prefs.setString(widget.business.name ?? '', json.encode(data));
//       } else {
//         prefs.remove(widget.business.name ?? '');
//       }
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content:
//             Text(isFavorite ? 'Added to Favorites' : 'Removed from Favorites'),
//       ),
//     );

//     widget.onFavoriteStatusChanged(); // Notify parent widget about the change
//   }

//   Future<void> _launchURL(BuildContext context, String url) async {
//     final Uri uri = Uri.parse(url);
//     try {
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri);
//       } else {
//         throw 'Could not launch $url';
//       }
//     } catch (e) {
//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not open the URL')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final photos = widget.business.photos ?? [];
//     final photoWidgets = photos.isNotEmpty
//         ? photos
//             .map((photoUrl) => Image.network(
//                   photoUrl,
//                   width: 100,
//                   height: 100,
//                   errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.error, size: 100),
//                 ))
//             .toList()
//         : [
//             Image.network('https://via.placeholder.com/100',
//                 width: 100, height: 100)
//           ];

//     return Column(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CustomInfoCard(
//                   title: widget.business.category ?? 'No category',
//                   name: widget.business.name ?? 'No name',
//                   address: widget.business.location?.toString() ?? 'No address',
//                   distance: '3.1 km away',
//                   time: '10 am - 5 pm',
//                   rating: widget.business.rating,
//                   onTap: () {},
//                 ),
//                 const SizedBox(height: 15),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             final phoneNumber = widget.business.contact;
//                             if (phoneNumber != null && phoneNumber.isNotEmpty) {
//                               _launchURL(context, 'tel:$phoneNumber');
//                             }
//                           },
//                           icon: const Icon(Icons.call, size: 16),
//                           label: const Text("Call",
//                               style: TextStyle(fontSize: 12)),
//                         ),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             final siteUrl = widget.business.website;
//                             if (siteUrl != null && siteUrl.isNotEmpty) {
//                               final validUrl = siteUrl.startsWith('http')
//                                   ? siteUrl
//                                   : 'http://$siteUrl';
//                               _launchURL(context, validUrl);
//                             }
//                           },
//                           icon: const Icon(Icons.web, size: 16),
//                           label: const Text("Website",
//                               style: TextStyle(fontSize: 12)),
//                         ),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             final location = widget.business.location;
//                             if (location != null) {
//                               final encodedLocation =
//                                   Uri.encodeComponent(location.toString());
//                               _launchURL(context,
//                                   'https://www.google.com/maps/search/?api=1&query=$encodedLocation');
//                             }
//                           },
//                           icon: const Icon(Icons.map, size: 16),
//                           label:
//                               const Text("Map", style: TextStyle(fontSize: 12)),
//                         ),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             final emailAddress = widget.business.email;
//                             if (emailAddress != null &&
//                                 emailAddress.isNotEmpty) {
//                               _launchURL(context, 'mailto:$emailAddress');
//                             }
//                           },
//                           icon: const Icon(Icons.email, size: 16),
//                           label: const Text("Email",
//                               style: TextStyle(fontSize: 12)),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Images',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     GridView.builder(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       shrinkWrap: true,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 8,
//                         mainAxisSpacing: 8,
//                       ),
//                       itemCount: photoWidgets.length,
//                       itemBuilder: (context, index) => photoWidgets[index],
//                     ),
//                     const SizedBox(height: 8),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Notes',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'This contact address was given by Surya for me to setup a meeting with this college.',
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           const Text(
//                             'Social Links:',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           IconButton(
//                             icon:
//                                 const Icon(Icons.facebook, color: Colors.blue),
//                             onPressed: () {
//                               _launchURL(context, 'https://www.facebook.com/');
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.camera_alt,
//                                 color: Colors.purple),
//                             onPressed: () {
//                               _launchURL(context, 'https://www.instagram.com/');
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.alternate_email,
//                                 color: Colors.blue),
//                             onPressed: () {
//                               _launchURL(context, 'mailto:example@example.com');
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: _toggleFavorite,
//             child: Container(
//               width: double.infinity,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.purpleAccent,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
//                     style: const TextStyle(fontSize: 20, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';

import 'package:connect_me_app/model/business/business_model.dart';
import 'package:connect_me_app/presentation/view/common/custom_card.dart';
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
    final status = prefs.getBool(widget.business.name ?? '') ?? false;
    setState(() {
      isFavorite = status;
    });
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
                CustomInfoCard(
                  title: widget.business.category ?? 'No category',
                  name: widget.business.name ?? 'No name',
                  address: widget.business.location?.toString() ?? 'No address',
                  distance: '3.1 km away',
                  time: '10 am - 5 pm',
                  rating: widget.business.rating,
                  onTap: () {},
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
