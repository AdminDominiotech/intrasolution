import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Acceso extends Equatable {
  Acceso({

    required this.modulos,
  });


  final String modulos;

  Map<String, dynamic> toJson();

  @override
  List<Object> get props => [

        modulos,
      ];
}
