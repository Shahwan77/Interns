import 'package:flutter/material.dart';

class ImageListScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'Assets/2.jpg',
    'Assets/3.jpg',
    'Assets/4.jpeg',
    'Assets/5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image ListView'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          childAspectRatio: 0.75, // Aspect ratio of each item (width/height)
          crossAxisSpacing: 8.0, // Horizontal space between items
          mainAxisSpacing: 8.0, // Vertical space between items
        ),
        itemCount: imageUrls.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              width: 150,
              child: Image.asset(
                imageUrls[index],
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
      ),
    );
  }
}