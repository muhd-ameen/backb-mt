// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.success,
    this.pagination,
    this.data,
  });

  bool success;
  Pagination pagination;
  Data data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    success: json["success"],
    pagination: Pagination.fromJson(json["pagination"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "pagination": pagination.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.branch,
    this.quick,
    this.restaurant,
  });

  Branch branch;
  List<Quick> quick;
  List<Quick> restaurant;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    branch: Branch.fromJson(json["branch"]),
    quick: List<Quick>.from(json["quick"].map((x) => Quick.fromJson(x))),
    restaurant: List<Quick>.from(json["restaurant"].map((x) => Quick.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "branch": branch.toJson(),
    "quick": List<dynamic>.from(quick.map((x) => x.toJson())),
    "restaurant": List<dynamic>.from(restaurant.map((x) => x.toJson())),
  };
}

class Branch {
  Branch({
    this.id,
    this.location,
    this.name,
    this.branchBanner,
    this.supportNumber,
    this.activePopup,
    this.status,
    this.offers,
    this.activeMessage,
    this.distance,
  });

  String id;
  BranchLocation location;
  String name;
  List<BranchBanner> branchBanner;
  int supportNumber;
  Pagination activePopup;
  bool status;
  List<Offer> offers;
  Pagination activeMessage;
  double distance;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["_id"],
    location: BranchLocation.fromJson(json["location"]),
    name: json["name"],
    branchBanner: List<BranchBanner>.from(json["branchBanner"].map((x) => BranchBanner.fromJson(x))),
    supportNumber: json["supportNumber"],
    activePopup: Pagination.fromJson(json["activePopup"]),
    status: json["status"],
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
    activeMessage: Pagination.fromJson(json["activeMessage"]),
    distance: json["distance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "location": location.toJson(),
    "name": name,
    "branchBanner": List<dynamic>.from(branchBanner.map((x) => x.toJson())),
    "supportNumber": supportNumber,
    "activePopup": activePopup.toJson(),
    "status": status,
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
    "activeMessage": activeMessage.toJson(),
    "distance": distance,
  };
}

class Pagination {
  Pagination();

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
  );

  Map<String, dynamic> toJson() => {
  };
}

class BranchBanner {
  BranchBanner({
    this.clickable,
    this.id,
    this.linkId,
    this.image,
  });

  bool clickable;
  String id;
  String linkId;
  String image;

  factory BranchBanner.fromJson(Map<String, dynamic> json) => BranchBanner(
    clickable: json["clickable"],
    id: json["_id"],
    linkId: json["linkId"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "clickable": clickable,
    "_id": id,
    "linkId": linkId,
    "image": image,
  };
}

class BranchLocation {
  BranchLocation({
    this.type,
    this.coordinates,
    this.address,
  });

  String type;
  List<double> coordinates;
  String address;

  factory BranchLocation.fromJson(Map<String, dynamic> json) => BranchLocation(
    type: json["type"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "address": address,
  };
}

class Offer {
  Offer({
    this.status,
    this.id,
    this.title,
    this.subtitle,
    this.primary,
    this.secondary,
    this.desc,
    this.type,
    this.link,
    this.image,
    this.icon,
  });

  bool status;
  String id;
  String title;
  String subtitle;
  String primary;
  String secondary;
  String desc;
  String type;
  dynamic link;
  IconModel image;
  IconModel icon;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    status: json["status"],
    id: json["_id"],
    title: json["title"],
    subtitle: json["subtitle"],
    primary: json["primary"],
    secondary: json["secondary"],
    desc: json["desc"],
    type: json["type"],
    link: json["link"],
    image: IconModel.fromJson(json["image"]),
    icon: IconModel.fromJson(json["icon"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "title": title,
    "subtitle": subtitle,
    "primary": primary,
    "secondary": secondary,
    "desc": desc,
    "type": type,
    "link": link,
    "image": image.toJson(),
    "icon": icon.toJson(),
  };
}

class IconModel {
  IconModel({
    this.mimetype,
    this.key,
    this.location,
  });

  String mimetype;
  String key;
  String location;

  factory IconModel.fromJson(Map<String, dynamic> json) => IconModel(
    mimetype: json["mimetype"],
    key: json["key"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "mimetype": mimetype,
    "key": key,
    "location": location,
  };
}

class LinkClass {
  LinkClass({
    this.restaurant,
    this.product,
  });

  String restaurant;
  String product;

  factory LinkClass.fromJson(Map<String, dynamic> json) => LinkClass(
    restaurant: json["restaurant"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "restaurant": restaurant,
    "product": product,
  };
}

class Quick {
  Quick({
    this.id,
    this.quickDelivery,
    this.storeStatus,
    this.featured,
    this.name,
    this.branch,
    this.avgCookingTime,
    this.avgPersonAmt,
    this.closeTime,
    this.cuisine,
    this.openTime,
    this.storeBg,
    this.storeLogo,
    this.location,
    this.distance,
  });

  String id;
  bool quickDelivery;
  bool storeStatus;
  bool featured;
  String name;
  String branch;
  String avgCookingTime;
  String avgPersonAmt;
  String closeTime;
  String cuisine;
  String openTime;
  String storeBg;
  String storeLogo;
  QuickLocation location;
  double distance;

  factory Quick.fromJson(Map<String, dynamic> json) => Quick(
    id: json["_id"],
    quickDelivery: json["quickDelivery"],
    storeStatus: json["storeStatus"],
    featured: json["featured"],
    name: json["name"],
    branch: json["branch"],
    avgCookingTime: json["avgCookingTime"],
    avgPersonAmt: json["avgPersonAmt"],
    closeTime: json["closeTime"],
    cuisine: json["cuisine"],
    openTime: json["openTime"],
    storeBg: json["storeBg"],
    storeLogo: json["storeLogo"],
    location: QuickLocation.fromJson(json["location"]),
    distance: json["distance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "quickDelivery": quickDelivery,
    "storeStatus": storeStatus,
    "featured": featured,
    "name": name,
    "branch": branch,
    "avgCookingTime": avgCookingTime,
    "avgPersonAmt": avgPersonAmt,
    "closeTime": closeTime,
    "cuisine": cuisine,
    "openTime": openTime,
    "storeBg": storeBg,
    "storeLogo": storeLogo,
    "location": location.toJson(),
    "distance": distance,
  };
}

class QuickLocation {
  QuickLocation({
    this.address,
  });

  String address;

  factory QuickLocation.fromJson(Map<String, dynamic> json) => QuickLocation(
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
  };
}
