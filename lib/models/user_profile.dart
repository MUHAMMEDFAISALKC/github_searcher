class UserProfile {
  String? name;
  String? imageUrl;
  String? email;
  String? location;
  String? joinDate;
  int? followers;
  int? following;
  String? biography;
  int? repoNum;

  UserProfile({
    this.name,
    this.imageUrl,
    this.email,
    this.location,
    this.joinDate,
    this.followers,
    this.following,
    this.biography,
    this.repoNum,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        name: json['login'],
        imageUrl: json['avatar_url'],
        email: json['email'],
        location: json['location'],
        joinDate: json['created_at'].toString().split('T')[0],
        followers: json['followers'],
        following: json['following'],
        biography: json['bio'],
        repoNum: json['public_repos']);
  }
}
