import 'package:flutter/material.dart';
import 'package:kototinder/domain/entities/cat_breed.dart';
import 'package:kototinder/domain/use_cases/get_all_breeds_use_case.dart';
import 'package:kototinder/presentation/screens/breed_detail_screen.dart';
import 'package:kototinder/presentation/widgets/error_handler.dart';
import 'package:kototinder/core/di/injection_container.dart';

class BreedsListScreen extends StatefulWidget {
  const BreedsListScreen({super.key});

  @override
  BreedsListScreenState createState() => BreedsListScreenState();
}

class BreedsListScreenState extends State<BreedsListScreen> {
  late GetAllBreedsUseCase _getAllBreedsUseCase;  List<CatBreed> breeds = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getAllBreedsUseCase = getIt<GetAllBreedsUseCase>();
    _loadBreeds();
  }

  Future<void> _loadBreeds() async {
    try {
      final breedsData = await _getAllBreedsUseCase.execute();
      if (mounted) {
        setState(() {
          breeds = breedsData;
          _isLoading = false;
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
        ErrorHandler.handle(e, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cat Breeds"),
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xfff9f4fb),
        titleTextStyle: TextStyle(
          color: Color(0xfff9f4fb),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? _buildErrorWidget()
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: breeds.length,
              itemBuilder: (context, index) {
                final breed = breeds[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfff9f4fb).withAlpha(50),
                        border: Border.all(color: Color(0x00a091ee), width: 1.5),
                      ),
                      child: Icon(Icons.pets, color: Color(0xffa091ee)),
                    ),
                    title: Text(
                      breed.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        breed.description ?? 'No description available',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BreedDetailScreen(
                            breed: breed,
                            imageUrl: null,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 60, color: Colors.red),
          SizedBox(height: 10),
          Text(
            "Loading failed",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            _errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          ElevatedButton(onPressed: _loadBreeds, child: Text("Retry")),
        ],
      ),
    );
  }
}
