class Profile {
  bool? success;
  String? status;
  String? message;
  ProfileData? data;

  Profile({this.success, this.status, this.message, this.data});

  Profile.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? id;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  bool? isEmailVerified;
  String? imageUrl;
  List<Subscriptions>? subscriptions;

  ProfileData(
      {this.id,
        this.firstname,
        this.lastname,
        this.phone,
        this.email,
        this.isEmailVerified,
        this.imageUrl,
        this.subscriptions});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    isEmailVerified = json['is_email_verified'];
    imageUrl = json['image_url'];
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(new Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['is_email_verified'] = this.isEmailVerified;
    data['image_url'] = this.imageUrl;
    if (this.subscriptions != null) {
      data['subscriptions'] =
          this.subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subscriptions {
  String? id;
  Deal? deal;

  Subscriptions({this.id, this.deal});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deal = json['deal'] != null ? new Deal.fromJson(json['deal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.deal != null) {
      data['deal'] = this.deal!.toJson();
    }
    return data;
  }
}

class Deal {
  String? id;
  SuperDeal? superDeal;

  Deal({this.id, this.superDeal});

  Deal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    superDeal = json['super_deal'] != null
        ? new SuperDeal.fromJson(json['super_deal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.superDeal != null) {
      data['super_deal'] = this.superDeal!.toJson();
    }
    return data;
  }
}

class SuperDeal {
  String? id;
  String? name;
  bool? isAvailable;

  SuperDeal({this.id, this.name, this.isAvailable});

  SuperDeal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isAvailable = json['is_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_available'] = this.isAvailable;
    return data;
  }
}
