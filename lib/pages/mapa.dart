import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo5/controllers/geolocator.dart';
import 'package:modulo5/styles/cores.dart';
import 'package:modulo5/styles/fonts.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  String end = '';
  List<Marker> marcadores = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: FutureBuilder(
          future: GeolocatorController.determinePosition(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              marcadores.add(
                Marker(
                  markerId: const MarkerId('posInicial'),
                  position: LatLng(
                    snapshot.data!.latitude,
                    snapshot.data!.longitude,
                  ),
                ),
              );
              return Column(
                children: [
                  Container(
                    width: width,
                    height: height * .2,
                    decoration: BoxDecoration(
                      color: Cores.azulClaro,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Selecionar destino',
                        style: TextStyle(
                          color: Cores.azulEscuro,
                          fontFamily: Fonts.fonte,
                          fontSize: Fonts.fontSubtitulo,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: width,
                      height: height * .8 - 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextField(
                            onChanged: (value) => end = value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              label: Text(
                                'Endereço',
                                style: TextStyle(
                                  color: Cores.azulClaro,
                                  fontFamily: Fonts.fonte,
                                  fontSize: Fonts.fontPadrao,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  var novoMark = await GeolocatorController
                                      .formatarEndereco(
                                    end,
                                  );
                                  if (novoMark != null) {
                                    setState(() {
                                      marcadores.add(
                                        Marker(
                                          markerId: const MarkerId('destino'),
                                          position: novoMark,
                                        ),
                                      );
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: Cores.azulClaro,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width,
                            height: height * .4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 3,
                                color: Cores.azulClaro,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: GoogleMap(
                                markers: {
                                  for (int i = 0; i < marcadores.length; i++)
                                    marcadores[i]
                                },
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    snapshot.data!.latitude,
                                    snapshot.data!.longitude,
                                  ),
                                  zoom: 10,
                                ),
                              ),
                            ),
                          ),
                          marcadores.length < 2
                              ? ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width, height * .06),
                                    backgroundColor: Cores.azulClaro,
                                  ),
                                  icon: Icon(
                                    Icons.send,
                                    color: Cores.azulEscuro,
                                  ),
                                  label: Text(
                                    'Iniciar Viagem',
                                    style: TextStyle(
                                      color: Cores.azulEscuro,
                                      fontFamily: Fonts.fonte,
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                              : ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width, height * .06),
                                    backgroundColor: Colors.grey,
                                  ),
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'Iniciar Viagem',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: Fonts.fonte,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Erro'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
