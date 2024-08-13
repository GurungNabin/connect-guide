import 'package:connect_me_app/presentation/view/common/custom_card.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Images',
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lorem ipsum dolor sit amet consectetur. Egestas mauris odio aliquam integer sed suspendisse. Interdum imperdiet condimentum pharetra varius. Nunc lorem in libero tempus. Quis malesuada pharetra non libero nec nisl.',
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(height: 16),

          // Services Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Services',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• nldjvdfjv'),
                Text('• jvjifvdk'),
                Text('• vdjnfvdnjv'),
                Text('• vndlnvkdmv'),
                Text('• ndnvkdmnvkdkvndkn'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
