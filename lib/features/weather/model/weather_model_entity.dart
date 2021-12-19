class WeatherModelEntity {
  WeatherModelEntity({
    required this.coord,
    required this.weatherEntity,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.cloudsEntity,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  final CoordsEntity coord;
  final List<WeatherEntity> weatherEntity;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final CloudsEntity cloudsEntity;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  factory WeatherModelEntity.fromMap(Map<String, dynamic> json) =>
      WeatherModelEntity(
        coord: CoordsEntity.fromMap(json['coord']),
        weatherEntity: List<WeatherEntity>.from(
            json['weather'].map((x) => WeatherEntity.fromMap(x))),
        base: json['base'],
        main: Main.fromMap(json['main']),
        visibility: json['visibility'],
        wind: Wind.fromMap(json['wind']),
        cloudsEntity: CloudsEntity.fromMap(json['cloudsEntity']),
        dt: json['dt'],
        sys: Sys.fromMap(json['sys']),
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod'],
      );

  Map<String, dynamic> toMap() => {
        'coord': coord.toMap(),
        'weather': List<dynamic>.from(weatherEntity.map((x) => x.toMap())),
        'base': base,
        'main': main.toMap(),
        'visibility': visibility,
        'wind': wind.toMap(),
        'cloudsEntity': cloudsEntity.toMap(),
        'dt': dt,
        'sys': sys.toMap(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod,
      };
}

class CloudsEntity {
  CloudsEntity({
    required this.all,
  });

  final int all;

  factory CloudsEntity.fromMap(Map<String, dynamic> json) => CloudsEntity(
        all: json['all'],
      );

  Map<String, dynamic> toMap() => {
        'all': all,
      };

  CloudsEntity copyWith({
    int? all,
  }) {
    return CloudsEntity(
      all: all ?? this.all,
    );
  }
}

class CoordsEntity {
  CoordsEntity({
    required this.lon,
    required this.lat,
  });

  final double lon;
  final double lat;

  factory CoordsEntity.fromMap(Map<String, dynamic> json) => CoordsEntity(
        lon: json['lon'].toDouble(),
        lat: json['lat'].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'lon': lon,
        'lat': lat,
      };

  CoordsEntity copyWith({
    double? lon,
    double? lat,
  }) {
    return CoordsEntity(
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
    );
  }
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  factory Main.fromMap(Map<String, dynamic> json) => Main(
        temp: json['temp'].toDouble(),
        feelsLike: json['feels_like'].toDouble(),
        tempMin: json['temp_min'].toDouble(),
        tempMax: json['temp_max'].toDouble(),
        pressure: json['pressure'],
        humidity: json['humidity'],
      );

  Map<String, dynamic> toMap() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
      };

  Main copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
  }) {
    return Main(
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
    );
  }
}

class Sys {
  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  factory Sys.fromMap(Map<String, dynamic> json) => Sys(
        type: json['type'],
        id: json['id'],
        country: json['country'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );

  Map<String, dynamic> toMap() => {
        'type': type,
        'id': id,
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      };
}

class WeatherEntity {
  WeatherEntity({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  factory WeatherEntity.fromMap(Map<String, dynamic> json) => WeatherEntity(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };

  WeatherEntity copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
    return WeatherEntity(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  final double speed;
  final int deg;

  factory Wind.fromMap(Map<String, dynamic> json) => Wind(
        speed: json['speed'].toDouble(),
        deg: json['deg'],
      );

  Map<String, dynamic> toMap() => {
        'speed': speed,
        'deg': deg,
      };

  Wind copyWith({
    double? speed,
    int? deg,
  }) {
    return Wind(
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
    );
  }
}
