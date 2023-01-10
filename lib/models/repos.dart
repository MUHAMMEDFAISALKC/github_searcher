class RepoCount {
  //String? name;
  int? repoCount;

  RepoCount({this.repoCount});

  factory RepoCount.fromJson(Map<String, dynamic> json) {
    return RepoCount(repoCount: json['public_repos']);
  }
}

class Repository {
  String? name;
  String? htmlUrl;
  int? stargazersCount;
  int? fork;

  Repository({
    this.name,
    this.htmlUrl,
    this.fork,
    this.stargazersCount,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      htmlUrl: json['html_url'],
      stargazersCount: json['stargazers_count'],
      fork: json['forks_count'],
    );
  }
}

class AllRepos {
  List<Repository>? allRepos;

  AllRepos({this.allRepos});

  factory AllRepos.fromJson(List<dynamic> json) {
    List<Repository> repos;
    repos = json.map((r) => Repository.fromJson(r)).toList();
    return AllRepos(allRepos: repos);
  }
}
