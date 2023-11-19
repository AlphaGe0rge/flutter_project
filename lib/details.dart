import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class DetailsPage extends StatelessWidget {

  const DetailsPage({super.key, required this.city});

  final City city;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.network(
                  city.image,
                  fit: BoxFit.cover,
              )
          ),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: BackButton(),
          ),
          Positioned(
              left: 0,
              top: 60,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      city.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white
                      ),
                    ),
                    Text(
                      city.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
