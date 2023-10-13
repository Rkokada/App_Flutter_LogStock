import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../controllers/location_controller.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final positionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
        init: LocationController(),
        builder: (controller) {
          late final position = controller.currentLocation;

          return Scaffold(
            appBar: AppBar(
              title: Text('Localização atual'),
            ),
            body: Center(
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //************************************************************************************************************* */
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Localização não pode ser vazio");
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: 18),
                          controller: positionController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () async{
                                await controller.getCurrentLocation();
                                positionController.text = (position).toString();
                                print(controller.currentLocation);
                              },
                              icon: Icon(Icons.pin_drop_outlined),
                            ),
                            hintStyle: TextStyle(fontSize: 18),
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 2.0, color: tSecondaryColor),
                            ),
                            labelText: 'Localização',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            controller.currentLocation == null
                                ? 'Nenhum endereço encontrado'
                                : controller.currentLocation!,
                            style: const TextStyle(fontSize: 23),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await controller.getCurrentLocation();
                            print(controller.currentLocation);
                          },
                          child: Text(' Atual'),
                        ),
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     await controller.getCurrentLocation();
                        //     print(controller.currentLocation);
                        //   },
                        //   child: Text('Obter localização atual'),
                        // ),
                      ],
                    ),
            ),
          );
        });
  }
}
