import 'package:flutter/material.dart';

class PopularScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF232323), // Set background color to match the rest of the app
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            buildListItem(
              context,
              'https://via.placeholder.com/100',
              'Taste',
              'Sabrina Carpenter',
            ),
            buildListItem(
              context,
              'https://via.placeholder.com/100',
              'Die With A Smile',
              'Lady Gaga, Bruno Mars',
            ),
            buildListItem(
              context,
              'https://via.placeholder.com/100',
              'I Had Some Help',
              'Post Malone, Morgan Wallen',
            ),
            // Add more ListTiles here
          ],
        ),
      ),
    );
  }

  // Helper method to build a custom list item with full control over layout
  Widget buildListItem(BuildContext context, String imageUrl, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Vertical spacing
      child: Row(
        children: [
          // Leading image with padding
          Padding(
            padding: const EdgeInsets.all(6.0), // Add padding around the image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0), // Rounded image corners
              child: Image.network(
                imageUrl,
                width: 40, // Smaller image size
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Title and subtitle
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0), // Horizontal spacing
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.white)),
                  Text(subtitle, style: TextStyle(color: Colors.white60)),
                ],
              ),
            ),
          ),
          // Trailing three dots icon with padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0), // Add padding around the icon
            child: IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white), // Three dots icon
              onPressed: () {
                // Show bottom sheet when three dots are clicked
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Color(0xFF232323), // Match the rest of the app's background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
                  ),
                  builder: (context) {
                    return buildBottomSheetContent(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Bottom sheet content when the three dots are clicked
  Widget buildBottomSheetContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.play_circle_outline, color: Colors.white),
            title: Text('Play', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet after selection
            },
          ),
          ListTile(
            leading: Icon(Icons.playlist_add, color: Colors.white),
            title: Text('Add to Playlist', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet after selection
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.white),
            title: Text('View Details', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet after selection
            },
          ),
        ],
      ),
    );
  }
}
