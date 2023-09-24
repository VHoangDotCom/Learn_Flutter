import 'package:flutter/material.dart';

void main() {
  runApp(Layout1());
}

class Layout1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Two Column Layout'),
        ),
        body: MyTwoColumnLayoutWidget(),
      ),
    );
  }
}

class MyTwoColumnLayoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4, // Left column takes 3 parts out of 10
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Add space between rows
              children: [
                Container(
                  color:
                      Colors.white, // Background color for the text container
                  padding: EdgeInsets.all(6),
                  child: Text('Strawberry Pavlova',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 16), // Add space between rows
                Container(
                  color:
                      Colors.white, // Background color for the text container
                  padding: EdgeInsets.all(6),
                  child: Text(
                      'A Flutter app is itself a widget, and most widgets have a build() method. ',
                      style: TextStyle(fontSize: 20)),
                ),
                SizedBox(height: 6), // Add space between rows
                Container(
                  color:
                      Colors.white, // Background color for the text container
                  padding: EdgeInsets.all(6),
                  child: Align(
                    alignment: Alignment.centerRight, // Align to the right
                    child: Row(
                      children: [
                        // List of smaller star icons
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        Icon(Icons.star, color: Colors.yellow, size: 20),

                        SizedBox(width: 8), // Add space between stars and text

                        // Text
                        Text(
                          '170 reviewers',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Container(
                  color:
                      Colors.white, // Background color for the text container
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Column 1
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Row 1
                            Icon(Icons.cabin, size: 24, color: Colors.green),
                            // Row 2
                            Text(
                              'PREP',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Row 3
                            Text('25 min', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),

                      // Column 2
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Row 1
                            Icon(Icons.alarm, size: 24, color: Colors.green),
                            // Row 2
                            Text(
                              'COOK',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Row 3
                            Text('1 hr', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),

                      // Column 3
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Row 1
                            Icon(Icons.pan_tool_sharp,
                                size: 24, color: Colors.green),
                            // Row 2
                            Text(
                              'FEEDS',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Row 3
                            Text('4-6', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6, // Right column takes 7 parts out of 10
          child: Container(
            color: Colors.white,
            child: Center(
              child: Container(
                height: double.infinity, // Take all available height
                child: Image.asset(
                  'assets/images/pancake.PNG',
                  width: 600,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
