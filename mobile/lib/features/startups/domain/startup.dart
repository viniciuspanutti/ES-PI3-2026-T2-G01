class StartupListItem {
  final String id;
  final String name;
  final String stage;
  final String shortDescription;
  final int capitalRaisedCents;
  final int totalTokensIssued;
  final int currentTokenPriceCents;
  final String? coverImageUrl;
  final List<String> tags;

  StartupListItem({
    required this.id,
    required this.name,
    required this.stage,
    required this.shortDescription,
    required this.capitalRaisedCents,
    required this.totalTokensIssued,
    required this.currentTokenPriceCents,
    this.coverImageUrl,
    required this.tags,
  });

  factory StartupListItem.fromJson(Map<String, dynamic> json) {
    return StartupListItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      stage: json['stage'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      capitalRaisedCents: json['capitalRaisedCents'] ?? 0,
      totalTokensIssued: json['totalTokensIssued'] ?? 0,
      currentTokenPriceCents: json['currentTokenPriceCents'] ?? 0,
      coverImageUrl: json['coverImageUrl'],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}

class StartupDetail extends StartupListItem {
  final String description;
  final String executiveSummary;
  final List<dynamic> founders;
  final List<dynamic> publicQuestions;
  final Map<String, dynamic> access;

  StartupDetail({
    required String id,
    required String name,
    required String stage,
    required String shortDescription,
    required int capitalRaisedCents,
    required int totalTokensIssued,
    required int currentTokenPriceCents,
    String? coverImageUrl,
    required List<String> tags,
    required this.description,
    required this.executiveSummary,
    required this.founders,
    required this.publicQuestions,
    required this.access,
  }) : super(
          id: id,
          name: name,
          stage: stage,
          shortDescription: shortDescription,
          capitalRaisedCents: capitalRaisedCents,
          totalTokensIssued: totalTokensIssued,
          currentTokenPriceCents: currentTokenPriceCents,
          coverImageUrl: coverImageUrl,
          tags: tags,
        );

  factory StartupDetail.fromJson(Map<String, dynamic> json) {
    return StartupDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      stage: json['stage'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      capitalRaisedCents: json['capitalRaisedCents'] ?? 0,
      totalTokensIssued: json['totalTokensIssued'] ?? 0,
      currentTokenPriceCents: json['currentTokenPriceCents'] ?? 0,
      coverImageUrl: json['coverImageUrl'],
      tags: List<String>.from(json['tags'] ?? []),
      description: json['description'] ?? '',
      executiveSummary: json['executiveSummary'] ?? '',
      founders: json['founders'] ?? [],
      publicQuestions: json['publicQuestions'] ?? [],
      access: json['access'] ?? {},
    );
  }
}