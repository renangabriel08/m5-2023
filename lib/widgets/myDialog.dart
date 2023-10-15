import 'package:flutter/material.dart';
import 'package:modulo5/controllers/pontos.dart';
import 'package:modulo5/styles/cores.dart';
import 'package:modulo5/styles/fonts.dart';

class MyDialog extends StatefulWidget {
  const MyDialog({super.key});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Pontos turisticos',
        style: TextStyle(color: Cores.azulEscuro),
      ),
      content: Pontos.pontosTuristicos.isEmpty
          ? SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  'Nenhum ponto turistico',
                  style: TextStyle(
                    color: Cores.azulEscuro,
                    fontFamily: Fonts.fonte,
                  ),
                ),
              ),
            )
          : SizedBox(
              height: Pontos.pontosTuristicos.length * 46,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < Pontos.pontosTuristicos.length; i++)
                    Container(
                      width: 300,
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Pontos.pontosTuristicosSelecionados[i]
                              ? Cores.azulEscuro
                              : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: Cores.azulEscuro,
                            value: Pontos.pontosTuristicosSelecionados[i],
                            onChanged: (value) => setState(() {
                              Pontos.pontosTuristicosSelecionados[i] = value;
                            }),
                          ),
                          Text(
                            "${Pontos.pontosTuristicos[i]['nome']}",
                            style: TextStyle(
                              fontFamily: Fonts.fonte,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'OK',
            style: TextStyle(
              color: Cores.azulEscuro,
              fontFamily: Fonts.fonte,
            ),
          ),
        ),
      ],
    );
  }
}
