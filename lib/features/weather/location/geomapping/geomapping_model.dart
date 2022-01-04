import 'dart:convert';

import 'package:flutter/foundation.dart';

class GeocodingResponse {
  GeocodingResponse({
    this.type,
    this.query,
    this.features,
    this.attribution,
  });

  final String? type;
  final List<String>? query;
  final List<Feature>? features;
  final String? attribution;

  GeocodingResponse copyWith({
    String? type,
    List<String>? query,
    List<Feature>? features,
    String? attribution,
  }) {
    return GeocodingResponse(
      type: type ?? this.type,
      query: query ?? this.query,
      features: features ?? this.features,
      attribution: attribution ?? this.attribution,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'query': query,
      'features': features?.map((x) => x.toMap()).toList(),
      'attribution': attribution,
    };
  }

  factory GeocodingResponse.fromMap(Map<String, dynamic> map) {
    return GeocodingResponse(
      type: map['type'],
      features: map['features'] != null
          ? map['features']?.map<Feature>((x) {
              return Feature.fromMap(x);
            }).toList()
          : const <Feature>[],
      attribution: map['attribution'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GeocodingResponse.fromJson(String source) =>
      GeocodingResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GeocodingResponse(type: $type, query: $query, features: $features, attribution: $attribution)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeocodingResponse &&
        other.type == type &&
        listEquals(other.query, query) &&
        listEquals(other.features, features) &&
        other.attribution == attribution;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        query.hashCode ^
        features.hashCode ^
        attribution.hashCode;
  }
}

class Feature {
  Feature({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.properties,
    this.text,
    this.placeName,
    this.bbox,
    this.center,
    this.geometry,
    this.context,
  });

  final String? id;
  final String? type;
  final List<String>? placeType;
  final num? relevance;
  final Properties? properties;
  final String? text;
  final String? placeName;
  final List<double>? bbox;
  final List<double>? center;
  final Geometry? geometry;
  final List<Context>? context;

  Feature copyWith({
    String? id,
    String? type,
    List<String>? placeType,
    num? relevance,
    Properties? properties,
    String? text,
    String? placeName,
    List<double>? bbox,
    List<double>? center,
    Geometry? geometry,
    List<Context>? context,
  }) {
    return Feature(
      id: id ?? this.id,
      type: type ?? this.type,
      placeType: placeType ?? this.placeType,
      relevance: relevance ?? this.relevance,
      properties: properties ?? this.properties,
      text: text ?? this.text,
      placeName: placeName ?? this.placeName,
      bbox: bbox ?? this.bbox,
      center: center ?? this.center,
      geometry: geometry ?? this.geometry,
      context: context ?? this.context,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'placeType': placeType,
      'relevance': relevance,
      'properties': properties?.toMap(),
      'text': text,
      'placeName': placeName,
      'bbox': bbox,
      'center': center,
      'geometry': geometry?.toMap(),
      'context': context?.map((x) => x.toMap()).toList(),
    };
  }

  factory Feature.fromMap(Map<String, dynamic> map) {
    final List? originalList = map['context'];
    final contextList = originalList != null && originalList.isNotEmpty
        ? originalList.map<Context>((item) {
            final context = Context.fromMap(item);
            return context;
          }).toList()
        : const <Context>[];

    return Feature(
      id: map['id'],
      type: map['type'],
      relevance: map['relevance'],
      properties: map['properties'] != null
          ? Properties.fromMap(map['properties'])
          : null,
      text: map['text'],
      placeName: map['placeName'],
      geometry:
          map['geometry'] != null ? Geometry.fromMap(map['geometry']) : null,
      context: contextList,
    );
  }

  String toJson() => json.encode(toMap());

  factory Feature.fromJson(String source) =>
      Feature.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Feature(id: $id, type: $type, placeType: $placeType, relevance: $relevance, properties: $properties, text: $text, placeName: $placeName, bbox: $bbox, center: $center, geometry: $geometry, context: $context)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Feature &&
        other.id == id &&
        other.type == type &&
        listEquals(other.placeType, placeType) &&
        other.relevance == relevance &&
        other.properties == properties &&
        other.text == text &&
        other.placeName == placeName &&
        listEquals(other.bbox, bbox) &&
        listEquals(other.center, center) &&
        other.geometry == geometry &&
        listEquals(other.context, context);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        placeType.hashCode ^
        relevance.hashCode ^
        properties.hashCode ^
        text.hashCode ^
        placeName.hashCode ^
        bbox.hashCode ^
        center.hashCode ^
        geometry.hashCode ^
        context.hashCode;
  }
}

class Context {
  Context({
    this.id,
    this.shortCode,
    this.wikidata,
    this.text,
  });

  final String? id;
  final String? shortCode;
  final String? wikidata;
  final String? text;

  Context copyWith({
    String? id,
    String? shortCode,
    String? wikidata,
    String? text,
  }) {
    return Context(
      id: id ?? this.id,
      shortCode: shortCode ?? this.shortCode,
      wikidata: wikidata ?? this.wikidata,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shortCode': shortCode,
      'wikidata': wikidata,
      'text': text,
    };
  }

  factory Context.fromMap(Map<String, dynamic> map) {
    return Context(
      id: map['id'],
      shortCode: map['shortCode'],
      wikidata: map['wikidata'],
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Context.fromJson(String source) =>
      Context.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Context(id: $id, shortCode: $shortCode, wikidata: $wikidata, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Context &&
        other.id == id &&
        other.shortCode == shortCode &&
        other.wikidata == wikidata &&
        other.text == text;
  }

  @override
  int get hashCode {
    return id.hashCode ^ shortCode.hashCode ^ wikidata.hashCode ^ text.hashCode;
  }
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  final String? type;
  final List<double>? coordinates;

  Geometry copyWith({
    String? type,
    List<double>? coordinates,
  }) {
    return Geometry(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      type: map['type'],
      coordinates: List<double>.from(map['coordinates']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Geometry.fromJson(String source) =>
      Geometry.fromMap(json.decode(source));

  @override
  String toString() => 'Geometry(type: $type, coordinates: $coordinates)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Geometry &&
        other.type == type &&
        listEquals(other.coordinates, coordinates);
  }

  @override
  int get hashCode => type.hashCode ^ coordinates.hashCode;
}

class Properties {
  Properties({
    this.wikidata,
    this.shortCode,
  });

  final String? wikidata;
  final String? shortCode;

  Properties copyWith({
    String? wikidata,
    String? shortCode,
  }) {
    return Properties(
      wikidata: wikidata ?? this.wikidata,
      shortCode: shortCode ?? this.shortCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wikidata': wikidata,
      'shortCode': shortCode,
    };
  }

  factory Properties.fromMap(Map<String, dynamic> map) {
    return Properties(
      wikidata: map['wikidata'],
      shortCode: map['shortCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Properties.fromJson(String source) =>
      Properties.fromMap(json.decode(source));

  @override
  String toString() => 'Properties(wikidata: $wikidata, shortCode: $shortCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Properties &&
        other.wikidata == wikidata &&
        other.shortCode == shortCode;
  }

  @override
  int get hashCode => wikidata.hashCode ^ shortCode.hashCode;
}
