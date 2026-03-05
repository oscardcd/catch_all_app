import 'package:flutter/material.dart';

class Palette {
  const Palette._();

  //Light Theme

//   {
//   "primary": "#0F2D52",
//   "secondary": "#4E8DF5",
//   "success": "#27AE60",
//   "warning": "#FF8300",
//   "gray": "#9B9B9B",
//   "black": "#1E1E1E",
//   "white": "#FFFFFF"
// }
//Esta paleta de colores está diseñada para ser atractiva y fácil de usar en una app de apuestas,
//con colores que indican éxito, advertencia y acción. El azul primario se puede utilizar como fondo principal,
// mientras que el azul secundario y el verde pueden usarse para elementos de interfaz de usuario como botones y enlaces.
// El naranja se puede usar para llamar la atención sobre elementos importantes,
//y el gris se puede usar para texto y fondos de bajo contraste.

//Dark Theme

// {

//     "background": "#1D1F21",
//     "surface": "#3A3D41",
//     "onSurface": "#E5E5EA",
//     "primary": "#4E8DF5",
//     "secondary": "#27AE60",
//     "error": "#FF4949"

// }
//En este ejemplo, el color de fondo principal es negro, y el color de superficie es un gris oscuro.
//El color de texto principal es un gris claro, y los colores de acento primario y secundario son el azul y el verde
// respectivamente. El color de error es rojo.

//Recuerda que puedes ajustar los valores de color según tus preferencias y necesidades de diseño.
// Además, asegúrate de probar la paleta de colores en diferentes dispositivos y entornos para garantizar una
//buena legibilidad y experiencia de usuario.

//Light
  static const primaryLight = Color(0xFF0F2D52);
  static const secondaryLight = Color(0xFF4E8DF5);
  static const buttonsLight = Color(0xFF27AE60);

//Dark
  static const primaryDark = Color(0xFF4E8DF5);
  static const secondaryDark = Color(0xFF27AE60);
  static const buttonsDark = Color(0xFFE5E5EA);
  static const onSurface = Color(0xFF3A3D41);

//Commons

  static const gray = Color(0xFF9B9B9B);
  static const black = Color(0xFF1E1E1E);
  static const white = Color(0xFFFFFFFF);

  static const success = Color(0xFF27AE60);
  static const warning = Color(0xFFFF8300);
  static const error = Color(0xFFFF4949);
  static const pokemonRed = Color(0xFFFF4444);

  // Other colors
  static const lightBlue = Color(0xFFE8F7FF);
  static const transparent = Colors.transparent;
  static const skyBlue = Color(0xFF9FC5FF);
  static const cyan = Color(0XFF9AD4FA);
  static const pink = Color(0XFFF2AAB6);
  static const lightPink = Color(0XFFF6C7B5);
  static const softBlue = Color(0xFFC2EDFA);

  // Gradients

  static List<Color> get primaryGradient => [
        buttonsLight,
        secondaryDark.withAlpha(200),
      ];
}
