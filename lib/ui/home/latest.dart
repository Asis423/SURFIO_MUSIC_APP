import 'package:flutter/material.dart';

class LatestSection extends StatelessWidget {
  final VoidCallback onSeeAll; // Callback for the "See All" button

  LatestSection({required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest Songs',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: onSeeAll, // Call the passed callback when "See All" is clicked
                child: Row(
                  children: [
                    Text('See All', style: TextStyle(color: Color(0xFFE0E0E0))),
                    Icon(Icons.arrow_forward_ios_outlined, color: Color(0xFFE0E0E0), size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 200, // Height of the horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Number of items in the list
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildMusicCard(),
              );
            },
          ),
        ),
      ],
    );
  }

  // Reusable widget to build music cards
  Widget _buildMusicCard() {
    return Container(
      width: 150, // Width of each card
      decoration: BoxDecoration(
        color: Color(0xFF3F3F3F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/150'), // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Hindi Top 50', // Example title
              style: TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Hindi Top 50', // Example subtitle
              style: TextStyle(color: Colors.white70, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
