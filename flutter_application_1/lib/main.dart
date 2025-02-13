import 'package:flutter/material.dart';

void main() {
  runApp(const DeathStarPlansApp());
}

class DeathStarPlansApp extends StatelessWidget {
  const DeathStarPlansApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Death Star Plans',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DeathStarPlansPage(),
    );
  }
}

class DeathStarPlansPage extends StatefulWidget {
  const DeathStarPlansPage({Key? key}) : super(key: key);

  @override
  _DeathStarPlansPageState createState() => _DeathStarPlansPageState();
}

class _DeathStarPlansPageState extends State<DeathStarPlansPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollbarHeight = 0.0;
  final double slideHeight = 720.0;
  final List<String> images = [
    'assets/images/image9.png',
    'assets/images/image13.png',
    'assets/images/image35.png',
    'assets/images/image9.png',
    'assets/images/image13.png',
    'assets/images/image35.png',
  ];

  void _updateScrollbarHeight() {
    final int totalSlides = images.length;
    final double scrollPosition = _scrollController.offset;
    final double newHeight = ((scrollPosition / (slideHeight * totalSlides)) * slideHeight).clamp(0, slideHeight);
    setState(() {
      _scrollbarHeight = newHeight;
    });
  }

  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      index * slideHeight,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollbarHeight);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollbarHeight());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Death Star Plans'),
        centerTitle: true,
        backgroundColor: const Color(0xFF6B9CB0),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Scroll Down To See Death Star Plans',
              style: TextStyle(
                color: Color(0xFF6B9CB0),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final String image = entry.value;
                    return GestureDetector(
                      onTap: () => _scrollToIndex(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Image.asset(
                          image,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 1,
                  height: slideHeight,
                  color: Colors.grey,
                  child: Stack(
                    children: [
                      Positioned(
                        top: _scrollbarHeight,
                        child: Container(
                          width: 1,
                          height: 50,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.contain,
                          width: 540,
                          height: slideHeight,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const FooterSection(),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF6B9CB0),
      padding: const EdgeInsets.all(16.0),
      child: const Text(
        'Team Projects, Team 4',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}