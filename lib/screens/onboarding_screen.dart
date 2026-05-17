import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Data model ───────────────────────────────────────────────────────────────

class CatBreed {
  final String image;
  final String title;
  final String description;
  final Color accentColor;

  const CatBreed({
    required this.image,
    required this.title,
    required this.description,
    required this.accentColor,
  });
}

const List<CatBreed> _breeds = [
  CatBreed(
    image: 'lib/assets/image/image1.jpg',
    title: 'Tabby American Shorthair',
    description:
        'A classic breed known for its friendly and adaptable nature. With a distinctive tabby coat pattern and a playful personality, these cats make wonderful companions.',
    accentColor: Color(0xFFE57373),
  ),
  CatBreed(
    image: 'lib/assets/image/image2.jpg',
    title: 'Orange British Shorthair',
    description:
        'Known for its charming orange coat and round face. These cats are celebrated for their calm and easygoing demeanor, making them great pets for families.',
    accentColor: Color(0xFFFF8A65),
  ),
  CatBreed(
    image: 'lib/assets/image/image3.jpg',
    title: 'Chartreux',
    description:
        'Originating in France, the Chartreux is characterised by its blue-grey coat and striking amber eyes. Intelligent and gentle, they are often considered gentle giants.',
    accentColor: Color(0xFF78909C),
  ),
  CatBreed(
    image: 'lib/assets/image/image4.jpg',
    title: 'Ragdoll',
    description:
        'Often called "puppy cats" for their love of following owners around. Ragdolls have striking blue eyes, a soft semi-long coat, and a wonderfully docile personality.',
    accentColor: Color(0xFF7986CB),
  ),
  CatBreed(
    image: 'lib/assets/image/image8.jpg',
    title: 'Calico',
    description:
        'Instantly recognisable by their tricolour coat of white, black, and orange. Calicos are independent with sassy personalities — and almost always female.',
    accentColor: Color(0xFFBA68C8),
  ),
];

// ── Main screen ──────────────────────────────────────────────────────────────

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool get _isFirstPage => _currentPage == 0;
  bool get _isLastPage => _currentPage == _breeds.length - 1;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (newPage != _currentPage) {
        setState(() => _currentPage = newPage);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _onGetStarted() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Welcome! Navigating to the app…'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onSkip() {
    _pageController.animateToPage(
      _breeds.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildDot(int index) {
    final bool isActive = _currentPage == index;
    final Color color = _breeds[_currentPage].accentColor;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isActive ? 24.0 : 10.0,
      height: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isActive ? color : color.withOpacity(0.25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final breed = _breeds[_currentPage];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.centerRight,
              child: AnimatedOpacity(
                opacity: _isLastPage ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: TextButton(
                  onPressed: _isLastPage ? null : _onSkip,
                  child: Text(
                    'Skip',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _breeds.length,
                itemBuilder: (context, index) {
                  return _OnBoardingPage(breed: _breeds[index]);
                },
              ),
            ),

            // Dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_breeds.length, _buildDot),
            ),

            const SizedBox(height: 32),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedOpacity(
                    opacity: _isFirstPage ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: _CircleButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      color: breed.accentColor,
                      onPressed: _isFirstPage ? null : _previousPage,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isLastPage
                        ? _GetStartedButton(
                            color: breed.accentColor,
                            onPressed: _onGetStarted,
                          )
                        : _CircleButton(
                            icon: Icons.arrow_forward_ios_rounded,
                            color: breed.accentColor,
                            onPressed: _nextPage,
                          ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── Page content ─────────────────────────────────────────────────────────────

class _OnBoardingPage extends StatelessWidget {
  final CatBreed breed;
  const _OnBoardingPage({required this.breed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular image with accent ring + glow
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: breed.accentColor, width: 3),
              boxShadow: [
                BoxShadow(
                  color: breed.accentColor.withOpacity(0.25),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                breed.image,
                width: 260,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 36),

          Text(
            breed.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: breed.accentColor,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            breed.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 16,
              height: 1.6,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Circle icon button ───────────────────────────────────────────────────────

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const _CircleButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.12),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: color, size: 24),
        ),
      ),
    );
  }
}

// ── Get Started button ───────────────────────────────────────────────────────

class _GetStartedButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const _GetStartedButton({
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        elevation: 4,
        shadowColor: color.withOpacity(0.4),
      ),
      child: Text(
        'Get Started',
        style: GoogleFonts.lato(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
