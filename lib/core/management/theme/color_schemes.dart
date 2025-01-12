import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4279985541),
      surfaceTint: Color(4279985541),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4291029247),
      onPrimaryContainer: Color(4278197804),
      secondary: Color(4283326829),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4291945971),
      onSecondaryContainer: Color(4278787624),
      tertiary: Color(4284504701),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4293320447),
      onTertiaryContainer: Color(4280031030),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294376190),
      onSurface: Color(4279704607),
      onSurfaceVariant: Color(4282468429),
      outline: Color(4285626493),
      outlineVariant: Color(4290824141),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086260),
      inversePrimary: Color(4287614963),
      primaryFixed: Color(4291029247),
      onPrimaryFixed: Color(4278197804),
      primaryFixedDim: Color(4287614963),
      onPrimaryFixedVariant: Color(4278209640),
      secondaryFixed: Color(4291945971),
      onSecondaryFixed: Color(4278787624),
      secondaryFixedDim: Color(4290103767),
      onSecondaryFixedVariant: Color(4281747796),
      tertiaryFixed: Color(4293320447),
      onTertiaryFixed: Color(4280031030),
      tertiaryFixedDim: Color(4291412458),
      onTertiaryFixedVariant: Color(4282925668),
      surfaceDim: Color(4292270815),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293586674),
      surfaceContainerHigh: Color(4293257709),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278208611),
      surfaceTint: Color(4279985541),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281891996),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281484624),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284774275),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282662496),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285952148),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294376190),
      onSurface: Color(4279704607),
      onSurfaceVariant: Color(4282205257),
      outline: Color(4284047461),
      outlineVariant: Color(4285824129),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086260),
      inversePrimary: Color(4287614963),
      primaryFixed: Color(4281891996),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4279657346),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284774275),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283129706),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4285952148),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4284307578),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292270815),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293586674),
      surfaceContainerHigh: Color(4293257709),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278199605),
      surfaceTint: Color(4279985541),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278208611),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279313455),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281484624),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280491581),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282662496),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294376190),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280165673),
      outline: Color(4282205257),
      outlineVariant: Color(4282205257),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086260),
      inversePrimary: Color(4292407295),
      primaryFixed: Color(4278208611),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278202692),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281484624),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280037178),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282662496),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281215048),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292270815),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293586674),
      surfaceContainerHigh: Color(4293257709),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4287614963),
      surfaceTint: Color(4287614963),
      onPrimary: Color(4278203721),
      primaryContainer: Color(4278209640),
      onPrimaryContainer: Color(4291029247),
      secondary: Color(4290103767),
      onSecondary: Color(4280300349),
      secondaryContainer: Color(4281747796),
      onSecondaryContainer: Color(4291945971),
      tertiary: Color(4291412458),
      onTertiary: Color(4281412684),
      tertiaryContainer: Color(4282925668),
      onTertiaryContainer: Color(4293320447),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279178263),
      onSurface: Color(4292862951),
      onSurfaceVariant: Color(4290824141),
      outline: Color(4287271575),
      outlineVariant: Color(4282468429),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inversePrimary: Color(4279985541),
      primaryFixed: Color(4291029247),
      onPrimaryFixed: Color(4278197804),
      primaryFixedDim: Color(4287614963),
      onPrimaryFixedVariant: Color(4278209640),
      secondaryFixed: Color(4291945971),
      onSecondaryFixed: Color(4278787624),
      secondaryFixedDim: Color(4290103767),
      onSecondaryFixedVariant: Color(4281747796),
      tertiaryFixed: Color(4293320447),
      onTertiaryFixed: Color(4280031030),
      tertiaryFixedDim: Color(4291412458),
      onTertiaryFixedVariant: Color(4282925668),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279704607),
      surfaceContainer: Color(4280033315),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4287878135),
      surfaceTint: Color(4287614963),
      onPrimary: Color(4278196516),
      primaryContainer: Color(4283930810),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290367195),
      onSecondary: Color(4278458402),
      secondaryContainer: Color(4286616480),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4291741422),
      onTertiary: Color(4279702064),
      tertiaryContainer: Color(4287859890),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279178263),
      onSurface: Color(4294507519),
      onSurfaceVariant: Color(4291153106),
      outline: Color(4288521385),
      outlineVariant: Color(4286416010),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inversePrimary: Color(4278210154),
      primaryFixed: Color(4291029247),
      onPrimaryFixed: Color(4278194973),
      primaryFixedDim: Color(4287614963),
      onPrimaryFixedVariant: Color(4278205265),
      secondaryFixed: Color(4291945971),
      onSecondaryFixed: Color(4278260509),
      secondaryFixedDim: Color(4290103767),
      onSecondaryFixedVariant: Color(4280695107),
      tertiaryFixed: Color(4293320447),
      onTertiaryFixed: Color(4279372843),
      tertiaryFixedDim: Color(4291412458),
      onTertiaryFixedVariant: Color(4281807442),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279704607),
      surfaceContainer: Color(4280033315),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294507519),
      surfaceTint: Color(4287614963),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4287878135),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294507519),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290367195),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294900223),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4291741422),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279178263),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294507519),
      outline: Color(4291153106),
      outlineVariant: Color(4291153106),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inversePrimary: Color(4278201920),
      primaryFixed: Color(4291685375),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4287878135),
      onPrimaryFixedVariant: Color(4278196516),
      secondaryFixed: Color(4292209400),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290367195),
      onSecondaryFixedVariant: Color(4278458402),
      tertiaryFixed: Color(4293583871),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4291741422),
      onTertiaryFixedVariant: Color(4279702064),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279704607),
      surfaceContainer: Color(4280033315),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
