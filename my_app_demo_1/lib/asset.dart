// import 'package:flutter/material.dart';

// class MyImageDisplayWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Image Display'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // Display an image from the assets folder
//               Image(
//                 image: AssetImage('assets/theme/get_asset.PNG'), // Asset path
//                 width: 200, // Set width (optional)
//                 height: 200, // Set height (optional)
//               ),
//               // Add other widgets or images as needed
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// void main() => runApp(MyImageDisplayWidget());

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyImageDisplayWidget());
// }

// class MyImageDisplayWidget extends StatelessWidget {
//   final List<String> imagePaths = [
//     'assets/theme/get_asset.PNG',
//     'assets/theme/delete_asset.PNG',
//     'assets/theme/update_asset.PNG',
//     'assets/theme/upload_level1.PNG',
//     'assets/theme/upload_level2.PNG',
//     'assets/theme/upload_multiple_files.PNG',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Image Slider Grid'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // Create a PageView to display the grid of images
//               Container(
//                 height: 400, // Set the height of the slider
//                 child: PageView.builder(
//                   itemCount: imagePaths.length,
//                   itemBuilder: (context, index) {
//                     return Image(
//                       image: AssetImage(imagePaths[index]),
//                       width: 200, // Set width (optional)
//                       height: 200, // Set height (optional)
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:convert';

// void main() {
//   runApp(MyImageDisplayWidget());
// }

// class MyImageDisplayWidget extends StatefulWidget {
//   @override
//   _MyImageDisplayWidgetState createState() => _MyImageDisplayWidgetState();
// }

// class _MyImageDisplayWidgetState extends State<MyImageDisplayWidget> {
//   final String folderName = 'assets/theme/';
//   final List<String> imagePaths = [];

//   @override
//   void initState() {
//     super.initState();
//     loadImages();
//   }

//   Future<void> loadImages() async {
//     final manifestContent = await rootBundle.loadString('AssetManifest.json');
//     final Map<String, dynamic> manifest = json.decode(manifestContent);

//     manifest.forEach((String key, dynamic value) {
//       final lowercaseKey = key.toLowerCase();
//       if (lowercaseKey.startsWith(folderName) &&
//           lowercaseKey.endsWith('.png')) {
//         imagePaths.add(key);
//       }
//     });

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Image Slider Grid'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 height: 400,
//                 child: PageView.builder(
//                   itemCount: imagePaths.length,
//                   itemBuilder: (context, index) {
//                     return Image(
//                       image: AssetImage(imagePaths[index]),
//                       width: 200,
//                       height: 200,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() {
  runApp(MyImageDisplayWidget());
}

class MyImageDisplayWidget extends StatefulWidget {
  @override
  _MyImageDisplayWidgetState createState() => _MyImageDisplayWidgetState();
}

class _MyImageDisplayWidgetState extends State<MyImageDisplayWidget> {
  final String folderName = 'assets/theme/';
  final List<String> imagePaths = [];
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifest = json.decode(manifestContent);

    manifest.forEach((String key, dynamic value) {
      final lowercaseKey = key.toLowerCase();
      if (lowercaseKey.startsWith(folderName) &&
          lowercaseKey.endsWith('.png')) {
        imagePaths.add(key);
      }
    });

    setState(() {});
  }

  void nextImage() {
    setState(() {
      if (currentIndex < imagePaths.length - 1) {
        currentIndex++;
        pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void prevImage() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        pageController.previousPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Slider Grid'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 400,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: imagePaths.length,
                      itemBuilder: (context, index) {
                        return Image(
                          image: AssetImage(imagePaths[index]),
                          width: 200,
                          height: 200,
                        );
                      },
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    Positioned(
                      left: 20,
                      child: GestureDetector(
                        onTap: prevImage,
                        child: Icon(
                          Icons.navigate_before,
                          size: 36,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      child: GestureDetector(
                        onTap: nextImage,
                        child: Icon(
                          Icons.navigate_next,
                          size: 36,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
