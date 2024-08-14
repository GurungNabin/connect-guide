import 'package:connect_me_app/presentation/view/common/custom_card.dart';
import 'package:flutter/material.dart';

class OverView extends StatelessWidget {
  const OverView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomInfoCard(
            title: 'College',
            name: 'College of Applied Business and Technology',
            address: 'Gangahity, Chabahil, Kathmandu 44600',
            distance: '3.1 km away',
            time: '10 am - 5 pm',
            rating: '3.1 rating',
            onTap: () {},
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                      size: 16,
                    ),
                    label: Text(
                      "Call",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.web,
                      size: 16,
                    ),
                    label: Text(
                      "Website",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.map,
                      size: 16,
                    ),
                    label: Text(
                      "Map",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.email,
                      size: 16,
                    ),
                    label: Text(
                      "Email",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Images',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network('https://via.placeholder.com/100',
                      width: 100, height: 100),
                  Image.network('https://via.placeholder.com/100',
                      width: 100, height: 100),
                  Image.network('https://via.placeholder.com/100',
                      width: 100, height: 100),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Notes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'This contact address was given by Surya for me to setup a meeting with this college.'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Social Links:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    
                  ],
                ),
                
              ),
              Container(
                child: IconButton(
                        icon: Icon(Icons.facebook, color: Colors.blue),
                        onPressed: () {},
                      ),
              ),
                    IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.purple),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.alternate_email, color: Colors.blue),
                      onPressed: () {},
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
