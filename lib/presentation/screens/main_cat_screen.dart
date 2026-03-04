import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kototinder/presentation/widgets/scaling_button.dart';
import 'package:kototinder/domain/entities/cat_image.dart';
import 'package:kototinder/domain/use_cases/get_random_cat_use_case.dart';
import 'package:kototinder/presentation/screens/breed_detail_screen.dart';
import 'package:kototinder/core/di/injection_container.dart';

import '../widgets/error_handler.dart';

class MainCatScreen extends StatefulWidget {
  const MainCatScreen({super.key});

  @override
  MainCatScreenState createState() => MainCatScreenState();
}

class MainCatScreenState extends State<MainCatScreen>
    with TickerProviderStateMixin {
  late GetRandomCatUseCase _getRandomCatUseCase;
  final List<CatImage> _catStack = [];
  int _likes = 0;
  bool _isLoading = true;
  final String _errorMessage = '';

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _getRandomCatUseCase = getIt<GetRandomCatUseCase>();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(1.5, 0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _preloadMultipleCats(count: 3);
  }

  Future<void> _preloadMultipleCats({int count = 3}) async {
    try {
      for (int i = 0; i < count; i++) {
        await _preloadNextCat();
      }
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ErrorHandler.handle(e, context);
      }
    }
  }

  Future<void> _preloadNextCat() async {
    try {
      final cat = await _getRandomCatUseCase.execute();
      if (mounted) {
        setState(() {
          _catStack.add(cat);
        });
      }
    } on Exception {
      rethrow;
    }
  }

  void _likeCat() {
    setState(() {
      _likes++;
      _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(1.5, 0)).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      );
    });

    _animationController.forward().then((_) {
      setState(() {
        _catStack.removeAt(0);
      });
      _preloadNextCat();
      _resetAnimation();
    });
  }

  void _dislikeCat() {
    setState(() {
      _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(-1.5, 0)).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      );
    });

    _animationController.forward().then((_) {
      setState(() {
        _catStack.removeAt(0);
      });
      _preloadNextCat();
      _resetAnimation();
    });
  }

  void _resetAnimation() {
    _animationController.reset();
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(1.5, 0)).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  void _showBreedDetails() {
    final breed = _catStack[0].breed;
    if (breed != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BreedDetailScreen(
            breed: breed,
            imageUrl: _catStack[0].url,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CatConnect"),
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Color(0xfff9f4fb),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "❤️ Likes: $_likes",
              style: TextStyle(
                color: Color(0xfff9f4fb),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                ? _buildErrorWidget()
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_catStack.length > 2)
                        Opacity(
                          opacity: 0.7,
                          child: Transform.scale(
                            scale: 0.95,
                            child: _buildCatCard(_catStack[2], false),
                          ),
                        ),
                      if (_catStack.length > 1)
                        Transform.scale(
                          scale: 0.98,
                          child: _buildCatCard(_catStack[1], false),
                        ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: _buildCatCard(_catStack[0], true),
                      ),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScalingButton(
                  onPressed: _dislikeCat,
                  child: ElevatedButton.icon(
                    onPressed: null,
                    label: Text("❌ Skip"),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Color(0xfff9f4fb),
                      ),
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Color(0xffa091ee),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      overlayColor: WidgetStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ScalingButton(
                  onPressed: _likeCat,
                  child: ElevatedButton.icon(
                    onPressed: null,
                    label: Text("✅ Like"),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Color(0xffa091ee),
                      ),
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Color(0xfff9f4fb),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      overlayColor: WidgetStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSwipe(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx.abs() < 100) return;

    final bool isLiked = details.velocity.pixelsPerSecond.dx > 0;

    setState(() {
      _slideAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: isLiked ? Offset(1.5, 0) : Offset(-1.5, 0),
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    });

    _animationController.forward().then((_) {
      if (isLiked) _likes++;

      setState(() {
        _catStack.removeAt(0);
      });

      _preloadNextCat();
      _resetAnimation();
    });
  }

  Widget _buildCatCard(CatImage cat, bool isActive) {
    return GestureDetector(
      onTap: isActive ? _showBreedDetails : null,
      onHorizontalDragEnd: isActive ? _handleSwipe : null,
      child: Container(
        margin: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: cat.url,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.broken_image, size: 40),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Text(
                    cat.breed?.name ?? 'Dvoroviy kotik',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 80, color: Colors.red),
          SizedBox(height: 10),
          Text(
            "Network error",
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          Text(
            _errorMessage,
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(onPressed: _preloadNextCat, child: Text("Retry")),
        ],
      ),
    );
  }
}
