class Investment {
  final String name;
  final String category;
  final String amount;
  final String returnRate;
  final String status;

  const Investment(
      this.name, this.category, this.amount, this.returnRate, this.status);
}

class Course {
  final String title;
  final String subtitle;
  final int progress;
  final String duration;
  final String category;

  const Course(
      this.title, this.subtitle, this.progress, this.duration, this.category);
}

class Opportunity {
  final String name;
  final String thesis;
  final String stage;
  final String raised;
  final String target;
  final String returnRate;

  const Opportunity(this.name, this.thesis, this.stage, this.raised,
      this.target, this.returnRate);
}

class CommunityPost {
  final String author;
  final String tribe;
  final String text;
  final String time;
  final String initials;

  const CommunityPost(
      this.author, this.tribe, this.text, this.time, this.initials);
}

class MockData {
  static const investments = [
    Investment('GridFlex', 'Distributed grid', '\$5,000', '+14.8%', 'Series A'),
    Investment(
        'Solarverse', 'Solar infrastructure', '\$2,500', '+9.2%', 'Seed'),
    Investment('VoltEdge', 'Battery storage', '\$7,500', '+11.6%', 'Series A'),
  ];

  static const courses = [
    Course(
        'Energy Investing 101',
        'Understand the infrastructure powering the next decade.',
        72,
        '4h 20m',
        'Investing'),
    Course('The Modern Grid', 'How resilient networks are changing energy.', 34,
        '2h 45m', 'Infrastructure'),
    Course(
        'Climate Technology',
        'A field guide to the teams building what comes next.',
        0,
        '3h 10m',
        'Technology'),
  ];

  static const opportunities = [
    Opportunity(
        'GridFlex',
        'Distributed energy infrastructure for resilient cities.',
        'Series A',
        '\$2.8M',
        '\$4M',
        '12.6%'),
    Opportunity(
        'Sunward Storage',
        'Long-duration storage for the renewable grid.',
        'Seed',
        '\$1.4M',
        '\$2.5M',
        '16.2%'),
    Opportunity(
        'Northline Mobility',
        'Charging infrastructure built for commercial fleets.',
        'Series B',
        '\$8.1M',
        '\$12M',
        '10.8%'),
  ];

  static const posts = [
    CommunityPost(
        'Sarah Mensah',
        'Solar Infrastructure',
        'Shared a field note from this week\'s community solar visit.',
        '2h ago',
        'SM'),
    CommunityPost(
        'Daniel Okafor',
        'Grid Builders',
        'What makes a resilient grid investable over the next decade?',
        '5h ago',
        'DO'),
    CommunityPost(
        'Maya Chen',
        'Climate Technology',
        'New report: the storage technologies worth watching.',
        'Yesterday',
        'MC'),
  ];
}
