import 'package:flutter/material.dart';

void main() {
  runApp(MyLandingPage());
}

class MyLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LandingPageContent(),
      ),
    );
  }
}

class LandingPageContent extends StatefulWidget {
  @override
  _LandingPageContentState createState() => _LandingPageContentState();
}

class _LandingPageContentState extends State<LandingPageContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> imageUrls = [
    'https://img.freepik.com/premium-photo/girl-looking-camera-while-using-computer-with-artificial-intelligence_131911-10.jpg',
    'https://statusneo.com/wp-content/uploads/2023/02/MicrosoftTeams-image551ad57e01403f080a9df51975ac40b6efba82553c323a742b42b1c71c1e45f1.jpg',
    'https://img.freepik.com/premium-photo/tired-girl-evening-light-sits-sofa-with-laptop-her-lap_556412-4590.jpg',
    'https://img.freepik.com/premium-photo/tired-girl-evening-light-sits-sofa-with-laptop-her-lap_556412-4590.jpg'
    // Add more image URLs as needed
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDotTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // First Row: Title Text and Additional Text Below
        Container(
          padding: EdgeInsets.all(16),
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TOKOTO',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Additional Text Below is a title in the landing page!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: screenHeight * 0.5,
                      color: Colors.grey,
                      child: Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
              ),
              Container(
                // Wrap with a Container
                alignment: Alignment.center, // Center the ListView.builder
                height: 20,
                child: ListView.builder(
                  itemCount: imageUrls.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _onDotTapped(index);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.orange
                                : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Third Row: Button with Larger Width
        Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Container(
              width: 400,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
