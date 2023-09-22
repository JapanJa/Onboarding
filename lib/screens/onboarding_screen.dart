import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
  );

  int _currentPage = 0; // Track the current page

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
      if (_pageController.page == 5.0) {
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 12.0,
      height: 12.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.pinkAccent : Colors.grey.withOpacity(0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return OnBoardingWidget(
                          image: "lib/assets/image/image1.jpg",
                          title: "Tabby American Shorthair Cat",
                          description:
                              "The Tabby American Shorthair cat is a classic breed known for its friendly and adaptable nature.\n With a distinctive tabby coat pattern and a playful personality, these cats make wonderful companions.",
                        );
                      case 1:
                        return OnBoardingWidget(
                          image: "lib/assets/image/image2.jpg",
                          title: "Orange British Shorthair",
                          description:
                              "The Orange British Shorthair cat is known for its charming orange coat and round face.\n These cats are known for their calm and easygoing demeanor, making them great pets for families.",
                        );
                      case 2:
                        return OnBoardingWidget(
                          image: "lib/assets/image/image3.jpg",
                          title: "Chartreux Cat",
                          description:
                              "The Chartreux cat is a breed that originated in France and is characterized by its blue-gray coat and striking amber eyes.\n These cats are known for their intelligence and are often considered as gentle giants due to their large size and sweet disposition.",
                        );
                      case 3:
                        return OnBoardingWidget(
                          image: "lib/assets/image/image4.jpg",
                          title: "Ragdoll Cat",
                          description:
                              "The Ragdoll cat is a breed known for its docile and affectionate nature.\n They are often called puppy cats because they enjoy following their owners around and being involved in family activities.\n Ragdolls have striking blue eyes and a soft, semi-long coat.",
                        );
                      case 4:
                        return OnBoardingWidget(
                          image: "lib/assets/image/image8.jpg",
                          title: "Calico Cat",
                          description:
                              "The Calico cat is known for its unique tricolor coat pattern, typically consisting of white, black, and orange colors.\n These cats are known for their independent and sassy personalities. Calicos are often female, and their distinctive coat patterns make them stand out in a crowd.",
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 6; i++) buildDot(i),
                ],
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.pinkAccent,
                        size: 30,
                      ),
                      onPressed: previousPage,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.pinkAccent,
                        size: 30,
                      ),
                      onPressed: nextPage,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.pinkAccent,
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
