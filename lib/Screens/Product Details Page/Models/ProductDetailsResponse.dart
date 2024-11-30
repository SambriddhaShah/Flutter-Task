import 'dart:convert';

class ProductDetailsResponse {
  String? title;
  String? message;
  ProductData? data;

  ProductDetailsResponse({
    this.title,
    this.message,
    this.data,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailsResponse(
      title: json['title'],
      message: json['message'],
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ProductData {
  String? id;
  String? slug;
  Category? category;
  Brand? brand;
  String? title;
  String? ingredient;
  String? howToUse;
  String? description;
  int? price;
  int? rewardPoint;
  int? commissionPercentage;
  int? strikePrice;
  int? offPercent;
  int? minOrder;
  int? maxOrder;
  bool? status;
  List<String>? images;
  List<ColorAttribute>? colorAttributes;
  String? variantType;
  List<ColorVariant>? colorVariants;
  int? ratings;
  int? totalRatings;
  int? ratedBy;
  FilterOptions? filterOptions;
  String? metaRobots;
  bool? isTodaysDeal;
  bool? isFeatured;
  bool? isPublished;
  String? searchWords;
  bool? isDeleted;
  List<Breadcrumb>? breadCrums;
  bool? wished;
  String? createdAt;
  String? updatedAt;

  ProductData({
    this.id,
    this.slug,
    this.category,
    this.brand,
    this.title,
    this.ingredient,
    this.howToUse,
    this.description,
    this.price,
    this.rewardPoint,
    this.commissionPercentage,
    this.strikePrice,
    this.offPercent,
    this.minOrder,
    this.maxOrder,
    this.status,
    this.images,
    this.colorAttributes,
    this.variantType,
    this.colorVariants,
    this.ratings,
    this.totalRatings,
    this.ratedBy,
    this.filterOptions,
    this.metaRobots,
    this.isTodaysDeal,
    this.isFeatured,
    this.isPublished,
    this.searchWords,
    this.isDeleted,
    this.breadCrums,
    this.wished,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['_id'],
      slug: json['slug'],
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      title: json['title'],
      ingredient: json['ingredient'],
      howToUse: json['howToUse'],
      description: json['description'],
      price: json['price'],
      rewardPoint: json['rewardPoint'],
      commissionPercentage: json['commissionPercentage'],
      strikePrice: json['strikePrice'],
      offPercent: json['offPercent'],
      minOrder: json['minOrder'],
      maxOrder: json['maxOrder'],
      status: json['status'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      colorAttributes: json['colorAttributes'] != null
          ? (json['colorAttributes'] as List)
              .map((e) => ColorAttribute.fromJson(e))
              .toList()
          : null,
      variantType: json['variantType'],
      colorVariants: json['colorVariants'] != null
          ? (json['colorVariants'] as List)
              .map((e) => ColorVariant.fromJson(e))
              .toList()
          : null,
      ratings: json['ratings'],
      totalRatings: json['totalRatings'],
      ratedBy: json['ratedBy'],
      filterOptions: json['filterOptions'] != null
          ? FilterOptions.fromJson(json['filterOptions'])
          : null,
      metaRobots: json['metaRobots'],
      isTodaysDeal: json['isTodaysDeal'],
      isFeatured: json['isFeatured'],
      isPublished: json['isPublished'],
      searchWords: json['searchWords'],
      isDeleted: json['isDeleted'],
      breadCrums: json['breadCrums'] != null
          ? (json['breadCrums'] as List)
              .map((e) => Breadcrumb.fromJson(e))
              .toList()
          : null,
      wished: json['wished'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'slug': slug,
      'category': category?.toJson(),
      'brand': brand?.toJson(),
      'title': title,
      'ingredient': ingredient,
      'howToUse': howToUse,
      'description': description,
      'price': price,
      'rewardPoint': rewardPoint,
      'commissionPercentage': commissionPercentage,
      'strikePrice': strikePrice,
      'offPercent': offPercent,
      'minOrder': minOrder,
      'maxOrder': maxOrder,
      'status': status,
      'images': images,
      'colorAttributes': colorAttributes?.map((e) => e.toJson()).toList(),
      'variantType': variantType,
      'colorVariants': colorVariants?.map((e) => e.toJson()).toList(),
      'ratings': ratings,
      'totalRatings': totalRatings,
      'ratedBy': ratedBy,
      'filterOptions': filterOptions?.toJson(),
      'metaRobots': metaRobots,
      'isTodaysDeal': isTodaysDeal,
      'isFeatured': isFeatured,
      'isPublished': isPublished,
      'searchWords': searchWords,
      'isDeleted': isDeleted,
      'breadCrums': breadCrums?.map((e) => e.toJson()).toList(),
      'wished': wished,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Category {
  String? id;
  String? slug;
  String? title;
  int? level;
  String? parentId;

  Category({
    this.id,
    this.slug,
    this.title,
    this.level,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      slug: json['slug'],
      title: json['title'],
      level: json['level'],
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'slug': slug,
      'title': title,
      'level': level,
      'parentId': parentId,
    };
  }
}

class Brand {
  String? id;
  String? slug;
  String? name;

  Brand({
    this.id,
    this.slug,
    this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'],
      slug: json['slug'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'slug': slug,
      'name': name,
    };
  }
}

class ColorAttribute {
  String? id;
  bool? isTwin;
  String? name;
  List<String>? colorValue;

  ColorAttribute({
    this.id,
    this.isTwin,
    this.name,
    this.colorValue,
  });

  factory ColorAttribute.fromJson(Map<String, dynamic> json) {
    return ColorAttribute(
      id: json['_id'],
      isTwin: json['isTwin'],
      name: json['name'],
      colorValue: json['colorValue'] != null ? List<String>.from(json['colorValue']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'isTwin': isTwin,
      'name': name,
      'colorValue': colorValue,
    };
  }
}

class ColorVariant {
  ColorAttribute? color;
  int? price;
  int? rewardPoint;
  int? strikePrice;
  int? offPercent;
  int? minOrder;
  int? maxOrder;
  bool? status;
  List<String>? images;
  String? productCode;
  String? id;

  ColorVariant({
    this.color,
    this.price,
    this.rewardPoint,
    this.strikePrice,
    this.offPercent,
    this.minOrder,
    this.maxOrder,
    this.status,
    this.images,
    this.productCode,
    this.id,
  });

  factory ColorVariant.fromJson(Map<String, dynamic> json) {
    return ColorVariant(
      color: json['color'] != null ? ColorAttribute.fromJson(json['color']) : null,
      price: json['price'],
      rewardPoint: json['rewardPoint'],
      strikePrice: json['strikePrice'],
      offPercent: json['offPercent'],
      minOrder: json['minOrder'],
      maxOrder: json['maxOrder'],
      status: json['status'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      productCode: json['productCode'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color?.toJson(),
      'price': price,
      'rewardPoint': rewardPoint,
      'strikePrice': strikePrice,
      'offPercent': offPercent,
      'minOrder': minOrder,
      'maxOrder': maxOrder,
      'status': status,
      'images': images,
      'productCode': productCode,
      '_id': id,
    };
  }
}

class FilterOptions {
  bool? age12;
  bool? age20;
  bool? age25;
  bool? age30;

  FilterOptions({
    this.age12,
    this.age20,
    this.age25,
    this.age30,
  });

  factory FilterOptions.fromJson(Map<String, dynamic> json) {
    return FilterOptions(
      age12: json['age12'],
      age20: json['age20'],
      age25: json['age25'],
      age30: json['age30'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age12': age12,
      'age20': age20,
      'age25': age25,
      'age30': age30,
    };
  }
}

class Breadcrumb {
  String? title;
  String? url;

  Breadcrumb({
    this.title,
    this.url,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) {
    return Breadcrumb(
      title: json['title'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
    };
  }
}
