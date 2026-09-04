import 'package:flutter/material.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/models/mock_data.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selected = 0;
  final destinations = const [
    _Destination('Home', Icons.home_rounded),
    _Destination('Learn', Icons.auto_stories_rounded),
    _Destination('Marketplace', Icons.storefront_rounded),
    _Destination('Community', Icons.groups_rounded),
    _Destination('Profile', Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= AppBreakpoints.desktop;
    final isTablet = width >= AppBreakpoints.tablet;
    final page = _pages[selected];
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (isTablet)
              _NavigationRail(
                  items: destinations,
                  selected: selected,
                  onSelected: _select,
                  wide: isWide),
            Expanded(
                child: Column(children: [
              if (isTablet) const _DesktopHeader(),
              Expanded(child: page),
            ])),
          ],
        ),
      ),
      bottomNavigationBar: isTablet
          ? null
          : SafeArea(
              top: false,
              child: _BottomNavigation(
                  items: destinations,
                  selected: selected,
                  onSelected: _select)),
    );
  }

  void _select(int value) => setState(() => selected = value);

  List<Widget> get _pages => const [
        HomeDestination(),
        LearnDestination(),
        MarketplaceDestination(),
        CommunityDestination(),
        ProfileDestination()
      ];
}

class _Destination {
  final String label;
  final IconData icon;
  const _Destination(this.label, this.icon);
}

class _NavigationRail extends StatelessWidget {
  final List<_Destination> items;
  final int selected;
  final ValueChanged<int> onSelected;
  final bool wide;
  const _NavigationRail(
      {required this.items,
      required this.selected,
      required this.onSelected,
      required this.wide});
  @override
  Widget build(BuildContext context) => Container(
        width: wide ? 230 : 86,
        color: AppColors.ink,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 14),
        child: Column(children: [
          Image.asset('assets/tribes_capital_logo.png',
              width: wide ? 170 : 54, height: 50, fit: BoxFit.contain),
          const SizedBox(height: 46),
          ...List.generate(
              items.length,
              (index) => _NavItem(
                  item: items[index],
                  active: selected == index,
                  wide: wide,
                  onTap: () => onSelected(index))),
          const Spacer(),
          Icon(Icons.help_outline_rounded,
              color: Colors.white.withValues(alpha: 0.5)),
        ]),
      );
}

class _NavItem extends StatelessWidget {
  final _Destination item;
  final bool active;
  final bool wide;
  final VoidCallback onTap;
  const _NavItem(
      {required this.item,
      required this.active,
      required this.wide,
      required this.onTap});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Semantics(
            button: true,
            selected: active,
            label: item.label,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                height: 52,
                padding: EdgeInsets.symmetric(horizontal: wide ? 16 : 0),
                decoration: BoxDecoration(
                    color: active ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.pill)),
                child: Row(
                    mainAxisAlignment: wide
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Icon(item.icon,
                          color: active ? AppColors.ink : Colors.white60,
                          size: 23),
                      if (wide) ...[
                        const SizedBox(width: 13),
                        Text(item.label,
                            style: TextStyle(
                                color: active ? AppColors.ink : Colors.white60,
                                fontWeight: FontWeight.w700))
                      ],
                    ]),
              ),
            )),
      );
}

class _BottomNavigation extends StatelessWidget {
  final List<_Destination> items;
  final int selected;
  final ValueChanged<int> onSelected;
  const _BottomNavigation(
      {required this.items, required this.selected, required this.onSelected});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
        child: Container(
          height: 64,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppColors.ink,
              borderRadius: BorderRadius.circular(AppRadius.pill)),
          child: Row(
              children: List.generate(items.length, (index) {
            final active = index == selected;
            return Expanded(
                child: Semantics(
                    button: true,
                    selected: active,
                    label: items[index].label,
                    child: InkWell(
                      onTap: () => onSelected(index),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 240),
                          decoration: BoxDecoration(
                              color: active ? Colors.white : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.pill)),
                          child: Center(
                              child: Icon(items[index].icon,
                                  color: active
                                      ? AppColors.ink
                                      : Colors.white60))),
                    )));
          })),
        ),
      );
}

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader();
  @override
  Widget build(BuildContext context) => Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.line))),
      child: Row(children: [
        const Spacer(),
        const Icon(Icons.notifications_none_rounded, color: AppColors.ink),
        const SizedBox(width: 22),
        const CircleAvatar(
            backgroundColor: AppColors.ink,
            child: Icon(Icons.person, color: Colors.white)),
        const SizedBox(width: 8),
        Text('Olaitan', style: Theme.of(context).textTheme.titleMedium)
      ]));
}

class _PageFrame extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;
  const _PageFrame(
      {required this.eyebrow,
      required this.title,
      required this.subtitle,
      required this.child});
  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final max =
            constraints.maxWidth >= AppBreakpoints.desktop ? 1180.0 : 720.0;
        return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.page, 26, AppSpacing.page, 40),
            child: Center(
                child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: max),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(eyebrow.toUpperCase(),
                              style: const TextStyle(
                                  color: AppColors.purple,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.4)),
                          const SizedBox(height: 8),
                          Text(title,
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          const SizedBox(height: 7),
                          Text(subtitle,
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 28),
                          child
                        ]))));
      });
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  const _SectionTitle(this.title, {this.action});
  @override
  Widget build(BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (action != null)
          Text(action!,
              style: const TextStyle(
                  color: AppColors.purple,
                  fontWeight: FontWeight.w700,
                  fontSize: 13))
      ]);
}

class _Card extends StatelessWidget {
  final Widget child;
  final Color color;
  const _Card({required this.child, this.color = AppColors.surface});
  @override
  Widget build(BuildContext context) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.line),
          boxShadow: [
            BoxShadow(
                color: AppColors.ink.withValues(alpha: 0.04),
                blurRadius: 22,
                offset: const Offset(0, 10))
          ]),
      child: child);
}

class HomeDestination extends StatelessWidget {
  const HomeDestination({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
      eyebrow: 'Friday, 04 September',
      title: 'Good morning, Olaitan.',
      subtitle: 'A clearer view of the energy transition starts here.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const _PortfolioHero(),
        const SizedBox(height: 26),
        const _SectionTitle('Your next move'),
        const SizedBox(height: 12),
        const _ActionRow(),
        const SizedBox(height: 28),
        const _SectionTitle('Your investments', action: 'View all'),
        const SizedBox(height: 12),
        const _InvestmentStrip(),
        const SizedBox(height: 28),
        const _SectionTitle('Across the Tribe', action: 'See activity'),
        const SizedBox(height: 12),
        const _ActivityCard()
      ]));
}

class _PortfolioHero extends StatelessWidget {
  const _PortfolioHero();
  @override
  Widget build(BuildContext context) => _Card(
      color: AppColors.ink,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Your portfolio',
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
              decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20)),
              child: const Text('This month',
                  style: TextStyle(color: Colors.white70, fontSize: 12)))
        ]),
        const SizedBox(height: 17),
        const Text('\$18,420.80',
            style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 7),
        const Row(children: [
          Icon(Icons.trending_up_rounded, color: Color(0xFFB7E7C8), size: 18),
          SizedBox(width: 5),
          Text('+12.48%',
              style: TextStyle(
                  color: Color(0xFFB7E7C8), fontWeight: FontWeight.w700)),
          Text('  from last month', style: TextStyle(color: Colors.white54))
        ]),
        const SizedBox(height: 20),
        SizedBox(
            height: 42,
            width: double.infinity,
            child: CustomPaint(painter: _ChartPainter()))
      ]));
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * .75)
      ..cubicTo(size.width * .18, size.height * .2, size.width * .28,
          size.height * .8, size.width * .43, size.height * .45)
      ..cubicTo(size.width * .58, size.height * .05, size.width * .7,
          size.height * .62, size.width, size.height * .12);
    canvas.drawPath(
        path,
        Paint()
          ..color = AppColors.lilac
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ActionRow extends StatelessWidget {
  const _ActionRow();

  @override
  Widget build(BuildContext context) {
    const actions = [
      ('Invest', Icons.north_east_rounded),
      ('Explore', Icons.explore_outlined),
      ('Learn', Icons.auto_stories_outlined),
      ('Community', Icons.groups_outlined),
    ];
    return Row(
      children: actions
          .map((action) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.line)),
                      child: Column(children: [
                        Icon(action.$2, color: AppColors.purple),
                        const SizedBox(height: 8),
                        Text(action.$1,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w700)),
                      ]),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class _InvestmentStrip extends StatelessWidget {
  const _InvestmentStrip();
  @override
  Widget build(BuildContext context) => SizedBox(
      height: 148,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: MockData.investments.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, index) {
            final item = MockData.investments[index];
            return SizedBox(
                width: 245,
                child: _Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.name,
                                style: Theme.of(context).textTheme.titleMedium),
                            Text(item.returnRate,
                                style: const TextStyle(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w800))
                          ]),
                      const SizedBox(height: 7),
                      Text(item.category,
                          style: Theme.of(context).textTheme.bodyMedium),
                      const Spacer(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.amount,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800)),
                            Text(item.status,
                                style: const TextStyle(
                                    color: AppColors.muted, fontSize: 12))
                          ])
                    ])));
          }));
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard();

  @override
  Widget build(BuildContext context) => _Card(
        child: Column(
          children: MockData.posts
              .map((post) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.lilac,
                              child: Text(post.initials,
                                  style: const TextStyle(
                                      color: AppColors.plum,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800))),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(post.author,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                                Text(post.text,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const SizedBox(height: 4),
                                Text('${post.tribe}  •  ${post.time}',
                                    style: const TextStyle(
                                        color: AppColors.purple,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700)),
                              ])),
                        ]),
                  ))
              .toList(),
        ),
      );
}

class LearnDestination extends StatelessWidget {
  const LearnDestination({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
      eyebrow: 'Learn',
      title: 'Build your energy fluency.',
      subtitle: 'Premium courses for the people shaping what comes next.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const _CourseHero(),
        const SizedBox(height: 28),
        const _SectionTitle('Explore learning', action: 'All courses'),
        const SizedBox(height: 12),
        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Energy',
              'Investing',
              'Infrastructure',
              'Climate',
              'Technology'
            ]
                .map((label) => Chip(
                    label: Text(label),
                    side: const BorderSide(color: AppColors.line),
                    backgroundColor: Colors.white,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w700)))
                .toList()),
        const SizedBox(height: 28),
        ...MockData.courses.skip(1).map((course) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _CourseRow(course: course)))
      ]));
}

class _CourseHero extends StatelessWidget {
  const _CourseHero();
  @override
  Widget build(BuildContext context) => _Card(
      color: AppColors.plum,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('CONTINUE LEARNING',
            style: TextStyle(
                color: AppColors.lilac,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2)),
        const SizedBox(height: 14),
        const Text('Energy Investing 101',
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        const Text('Understand the infrastructure powering the next decade.',
            style: TextStyle(color: Colors.white70, height: 1.4)),
        const SizedBox(height: 22),
        ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
                value: .72,
                minHeight: 6,
                backgroundColor: Colors.white24,
                color: AppColors.lilac)),
        const SizedBox(height: 10),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('72% complete',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text('Continue  →',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
        ])
      ]));
}

class _CourseRow extends StatelessWidget {
  final Course course;
  const _CourseRow({required this.course});
  @override
  Widget build(BuildContext context) => _Card(
          child: Row(children: [
        Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
                color: AppColors.lilac,
                borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.play_arrow_rounded, color: AppColors.plum)),
        const SizedBox(width: 14),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(course.title,
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 5),
          Text('${course.category}  •  ${course.duration}',
              style: const TextStyle(color: AppColors.muted, fontSize: 12)),
          const SizedBox(height: 10),
          LinearProgressIndicator(
              value: course.progress / 100,
              minHeight: 4,
              color: AppColors.purple,
              backgroundColor: AppColors.line)
        ]))
      ]));
}

class MarketplaceDestination extends StatelessWidget {
  const MarketplaceDestination({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
      eyebrow: 'Energy infrastructure marketplace',
      title: 'Capital with a point of view.',
      subtitle: 'Curated opportunities building the systems our future needs.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(
            spacing: 8,
            children: ['Featured', 'Solar', 'Storage', 'Grid', 'Mobility']
                .map((x) => ChoiceChip(
                    label: Text(x),
                    selected: x == 'Featured',
                    onSelected: (_) {},
                    selectedColor: AppColors.ink,
                    labelStyle: TextStyle(
                        color: x == 'Featured' ? Colors.white : AppColors.ink)))
                .toList()),
        const SizedBox(height: 26),
        ...MockData.opportunities.map((opportunity) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _OpportunityCard(opportunity: opportunity)))
      ]));
}

class _OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;
  const _OpportunityCard({required this.opportunity});
  @override
  Widget build(BuildContext context) => _Card(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(opportunity.name, style: Theme.of(context).textTheme.titleLarge),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  color: AppColors.lilac,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(opportunity.stage,
                  style: const TextStyle(
                      color: AppColors.plum,
                      fontSize: 12,
                      fontWeight: FontWeight.w800)))
        ]),
        const SizedBox(height: 8),
        Text(opportunity.thesis, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _Metric('Raised', opportunity.raised),
          _Metric('Target', opportunity.target),
          _Metric('Projected', '${opportunity.returnRate}%')
        ]),
        const SizedBox(height: 18),
        SizedBox(
            width: double.infinity,
            child: OutlinedButton(
                onPressed: () {}, child: const Text('Explore opportunity')))
      ]));
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  const _Metric(this.label, this.value);
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(color: AppColors.muted, fontSize: 11)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800))
      ]);
}

class CommunityDestination extends StatelessWidget {
  const CommunityDestination({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
      eyebrow: 'Community',
      title: 'Good evening, Tribe.',
      subtitle: 'Here is what is moving across the community.',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const _CommunityHero(),
        const SizedBox(height: 28),
        const _SectionTitle('Find your people', action: 'Discover'),
        const SizedBox(height: 12),
        SizedBox(
            height: 105,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, index) => _TribePill(
                    name: [
                      'Solar',
                      'Grid',
                      'Storage',
                      'Climate',
                      'Mobility'
                    ][index],
                    icon: [
                      Icons.wb_sunny_outlined,
                      Icons.bolt,
                      Icons.battery_charging_full,
                      Icons.eco_outlined,
                      Icons.electric_car_outlined
                    ][index]))),
        const SizedBox(height: 22),
        const _SectionTitle('Latest conversations'),
        const SizedBox(height: 12),
        _Card(
            child: Column(
                children: MockData.posts
                    .map((post) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                            backgroundColor: AppColors.lilac,
                            child: Text(post.initials,
                                style: const TextStyle(
                                    color: AppColors.plum, fontSize: 11))),
                        title: Text(post.author,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        subtitle: Text(post.text),
                        trailing: const Icon(Icons.chevron_right_rounded)))
                    .toList()))
      ]));
}

class _CommunityHero extends StatelessWidget {
  const _CommunityHero();
  @override
  Widget build(BuildContext context) => _Card(
      color: AppColors.ink,
      child: Row(children: [
        const Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('THE TRIBE',
              style: TextStyle(
                  color: AppColors.lilac,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2)),
          SizedBox(height: 10),
          Text('Ideas become infrastructure when we build together.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.15))
        ])),
        const Icon(Icons.forum_outlined, color: AppColors.lilac, size: 50)
      ]));
}

class _TribePill extends StatelessWidget {
  final String name;
  final IconData icon;
  const _TribePill({required this.name, required this.icon});
  @override
  Widget build(BuildContext context) => Container(
      width: 105,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.line)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: AppColors.purple),
            Text(name, style: const TextStyle(fontWeight: FontWeight.w700))
          ]));
}

class ProfileDestination extends StatelessWidget {
  const ProfileDestination({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
      eyebrow: 'Profile',
      title: 'Your journey, in one place.',
      subtitle: 'A living view of your capital, curiosity and community.',
      child: Column(children: [
        const _ProfileHeader(),
        const SizedBox(height: 18),
        const _JourneyCard(),
        const SizedBox(height: 18),
        _Card(
            child: Column(
                children: [
          'Portfolio',
          'Learning progress',
          'Saved opportunities',
          'Documents',
          'Preferences'
        ]
                    .map((item) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(item,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () {}))
                    .toList()))
      ]));
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();
  @override
  Widget build(BuildContext context) => _Card(
          child: Row(children: [
        const CircleAvatar(
            radius: 34,
            backgroundColor: AppColors.ink,
            child: Icon(Icons.person, color: Colors.white, size: 32)),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Olaitan', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 5),
          const Text('Energy transition investor',
              style: TextStyle(color: AppColors.muted))
        ])
      ]));
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard();
  @override
  Widget build(BuildContext context) => _Card(
      color: AppColors.lilac,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('YOUR JOURNEY',
            style: TextStyle(
                color: AppColors.plum,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2)),
        const SizedBox(height: 18),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _Metric('Invested', '\$15k'),
          _Metric('Learning', '72%'),
          _Metric('Community', '18 posts')
        ])
      ]));
}
