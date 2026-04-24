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
  final List<Map<String, String>> faq;
  final String? videoUrl;
  final List<Map<String, dynamic>> society;
  final Map<String, dynamic> access;

  StartupDetail({
    required super.id,
    required super.name,
    required super.stage,
    required super.shortDescription,
    required super.capitalRaisedCents,
    required super.totalTokensIssued,
    required super.currentTokenPriceCents,
    super.coverImageUrl,
    required super.tags,
    required this.description,
    required this.executiveSummary,
    required this.faq,
    this.videoUrl,
    required this.society,
    required this.access,
  });

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
      faq:
          (json['faq'] as List?)
              ?.map((item) => Map<String, String>.from(item))
              .toList() ??
          [],
      videoUrl: json['videoUrl'],
      society:
          (json['society'] as List?)
              ?.map((item) => Map<String, dynamic>.from(item))
              .toList() ??
          [],
      access: json['access'] ?? {},
    );
  }
}
