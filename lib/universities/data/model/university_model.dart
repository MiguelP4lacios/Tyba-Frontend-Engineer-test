class University {
  University({
    this.alphaTwoCode,
    this.domains,
    this.country,
    this.stateProvince,
    this.webPages,
    this.name,
  });

  University.fromJson(Map<String, dynamic> json) {
    alphaTwoCode = json['alpha_two_code'] as String?;
    domains = (json['domains'] as List).map((e) => e as String).toList();
    country = json['country'] as String?;
    stateProvince = json['state-province'] as String?;
    webPages = (json['web_pages'] as List).map((e) => e as String).toList();
    name = json['name'] as String?;
  }

  String? alphaTwoCode;
  List<String>? domains;
  String? country;
  String? stateProvince;
  List<String>? webPages;
  String? name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['alpha_two_code'] = alphaTwoCode;
    data['domains'] = domains;
    data['country'] = country;
    data['state-province'] = stateProvince;
    data['web_pages'] = webPages;
    data['name'] = name;
    return data;
  }
}
