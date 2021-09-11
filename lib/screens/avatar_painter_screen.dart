import 'package:flutter/material.dart';

import 'package:drawme/components/avatar_canvas.dart';

import 'package:drawme/models/avatar.dart';

class AvatarPainterScreen extends StatefulWidget {
  const AvatarPainterScreen({Key? key}) : super(key: key);

  @override
  _AvatarPainterScreenState createState() => _AvatarPainterScreenState();
}

class _AvatarPainterScreenState extends State<AvatarPainterScreen> {
  Map<String, String> layers = {
    'background': 'lib/assets/images/Man/background.png',
    'body': 'lib/assets/images/Man/body.png',
    'eyes': 'lib/assets/images/Man/eyes.png',
    'nose': 'lib/assets/images/Man/nose.png',
    'mouth': 'lib/assets/images/Man/mouth.png',
  };

  String _selectedLayer = 'nose';

  void _selectLayer(String layerName) {
    setState(() {
      _selectedLayer = layerName;
    });
  }

  void _selectLayerImage(String layerName, String imagePath) {
    if (layers.containsKey(layerName)) {
      setState(() {
        layers[layerName] = imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatar = ModalRoute.of(context)?.settings.arguments as Avatar;

    return Scaffold(
      appBar: AppBar(
        title: Text(avatar.name),
      ),
      body: Column(
        children: [
          AvatarCanvas(layers),
          Container(
            height: 55,
            width: double.infinity,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.black),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: avatar.layers.entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _selectLayer(entry.key),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.blue.shade800,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        entry.key,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height: 280,
            width: double.infinity,
            color: Colors.grey.shade400,
            child: GridView.builder(
              itemCount: avatar.layers[_selectedLayer]!.length,
              itemBuilder: (ctx, i) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GridTile(
                    child: GestureDetector(
                      onTap: () => _selectLayerImage(
                          _selectedLayer, avatar.layers[_selectedLayer]![i]),
                      child: Image.asset(
                        avatar.layers[_selectedLayer]![i], 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
