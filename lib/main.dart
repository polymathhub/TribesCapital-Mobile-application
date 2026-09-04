import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const TribesCapitalApp());

class TribesCapitalApp extends StatelessWidget {
  const TribesCapitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tribes Capital',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F8FA),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 108, 46, 201)),
        fontFamily: 'Arial',
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  final pages = const [
    HomePage(),
    SimplePage(title: 'Learn', icon: Icons.school),
    SimplePage(title: 'Marketplace', icon: Icons.storefront),
    SimplePage(title: 'Community', icon: Icons.groups),
    SimplePage(title: 'Profile', icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(52, 8, 52, 14),
          child: BottomPill(
            selected: index,
            onSelected: (value) => setState(() => index = value),
          ),
        ),
      ),
    );
  }
}

class BottomPill extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelected;

  const BottomPill({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const _items = <_NavItem>[
    _NavItem(Icons.home_rounded, 'Home'),
    _NavItem(Icons.auto_stories_rounded, 'Learn'),
    _NavItem(Icons.storefront_rounded, 'Marketplace'),
    _NavItem(Icons.groups_rounded, 'Community'),
    _NavItem(Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF171326),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isActive = index == selected;

          return Expanded(
            flex: isActive ? 2 : 1,
            child: Semantics(
              button: true,
              selected: isActive,
              label: item.label,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOutCubic,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: EdgeInsets.symmetric(
                    horizontal: isActive ? 8 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.white
                        : const Color.fromARGB(0, 9, 9, 9),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            size: isActive ? 28 : 25,
                            color: isActive
                                ? const Color(0xFF171326)
                                : const Color(0xFFB9B4C8),
                          ),
                          if (isActive) ...[
                            const SizedBox(width: 5),
                            Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 1, 1, 2),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 12, 22, 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8FA).withValues(alpha: 0.9),
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFF171326).withValues(alpha: 0.04),
                  width: 1,
                ),
              ),
            ),
            child: const Row(
              children: [
                BrandMenuButton(),
                Spacer(),
                Row(children: [
                  CircleButton(icon: Icons.notifications_none_rounded),
                  SizedBox(width: 12),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 7, 6, 9),
                    child: Icon(Icons.person, color: Colors.white, size: 22),
                  ),
                ]),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 28),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 14),
                      const Text(
                        'Hello Olaitan,',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: Color(0xFF171326),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Enabling the energy transition together.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 28, 27, 32),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const WalletCard(),
                      const SizedBox(height: 16),
                      const QuickActions(),
                      const SizedBox(height: 16),
                      const SectionCard(
                        title: 'Community',
                        child: CommunityGrid(),
                      ),
                      const SizedBox(height: 16),
                      const SectionCard(
                        title: 'Your Investments',
                        child: Column(
                          children: [
                            InvestmentRow('GridFlex', 'Series A', '\$5,000.00',
                                'May 12, 2024', Icons.bolt),
                            InvestmentRow('Solarverse', 'Seed', '\$2,500.00',
                                'May 10, 2024', Icons.wb_sunny_outlined),
                            InvestmentRow('VoltEdge', 'Series A', '\$7,500.00',
                                'May 8, 2024', Icons.battery_charging_full),
                            InvestmentRow('EcoWatt', 'Seed', '\$3,250.00',
                                'May 5, 2024', Icons.eco_outlined),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SectionCard(
                        title: 'Upcoming Events',
                        child: Column(children: [
                          EventRow(
                              day: '20',
                              month: 'MAY',
                              title: 'Energy Tech Summit 2024',
                              subtitle: 'Virtual Event'),
                          Divider(height: 20),
                          EventRow(
                              day: '28',
                              month: 'MAY',
                              title: 'Investor Roundtable',
                              subtitle: 'Private Event'),
                        ]),
                      ),
                      const SizedBox(height: 16),
                      const InsightsCarousel(),
                      const SizedBox(height: 16),
                      const SectionCard(
                        title: 'Community Activity',
                        child: Column(children: [
                          ActivityRow('Sarah M. joined the community', '2h ago',
                              Icons.person_add_alt_1),
                          ActivityRow('VoltEdge raised \$18.3M in Series A',
                              '5h ago', Icons.bolt),
                          ActivityRow(
                              'New report published: Global Energy Tech Outlook 2024',
                              '1d ago',
                              Icons.description_outlined),
                        ]),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BrandMenuButton extends StatelessWidget {
  const BrandMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Image.asset(
        'assets/tribes_capital_logo.png',
        width: 150,
        height: 50,
        fit: BoxFit.contain,
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  const CircleButton({super.key, required this.icon});
  @override
  Widget build(BuildContext context) => Container(
        width: 42,
        height: 42,
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon, size: 23),
      );
}

class WalletCard extends StatefulWidget {
  const WalletCard({super.key});

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  _WalletCardType activeCard = _WalletCardType.evm;

  static const ink = Color(0xFF15131B);
  static const evmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE4E5E9), Color(0xFFC8CBD2)],
  );
  static const paymentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFB34AE7), Color(0xFF8624C9)],
  );

  @override
  Widget build(BuildContext context) {
    final evmIsActive = activeCard == _WalletCardType.evm;

    return SizedBox(
      height: 262,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeInOutCubic,
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 82,
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
              decoration: BoxDecoration(
                gradient: evmGradient,
                borderRadius: BorderRadius.circular(26),
              ),
              child: GestureDetector(
                onTap: () => setState(() {
                  activeCard = _WalletCardType.evm;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: ink,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.credit_card_rounded,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      '0x7A3F...9C21',
                      style: TextStyle(
                        color: ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeInOutCubic,
            top: evmIsActive ? 0 : 46,
            left: 0,
            right: 0,
            child: Container(
              height: evmIsActive ? 82 : 176,
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
              decoration: BoxDecoration(
                gradient: paymentGradient,
                borderRadius: BorderRadius.circular(26),
              ),
              child: GestureDetector(
                onTap: () => setState(() {
                  activeCard = _WalletCardType.payment;
                }),
                child: evmIsActive
                    ? const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '•••• •••• •••• 4364',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '•••• •••• •••• 4364',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Balance',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    '\$3,922.40',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 31,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.8,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Exp. Date',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '08/28',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Nasara Friday G.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          if (evmIsActive)
            Positioned(
              top: 46,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => setState(() {
                  activeCard = _WalletCardType.payment;
                }),
                child: Container(
                  height: 176,
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
                  decoration: BoxDecoration(
                    gradient: evmGradient,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '0x7A3F...9C21',
                          style: TextStyle(
                            color: ink,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Balance',
                                style: TextStyle(
                                  color: ink,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '\$3,922.40',
                                style: TextStyle(
                                  color: ink,
                                  fontSize: 31,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.8,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'EVM / DeFi',
                            style: TextStyle(
                              color: ink,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Connected wallet',
                          style: TextStyle(
                            color: ink,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            top: 58,
            right: 18,
            child: Tooltip(
              message: 'Switch card',
              child: Semantics(
                button: true,
                label: 'Switch card',
                child: GestureDetector(
                  onTap: () => setState(() {
                    activeCard = evmIsActive
                        ? _WalletCardType.payment
                        : _WalletCardType.evm;
                  }),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: evmIsActive ? Colors.black : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.swap_horiz_rounded,
                      size: 21,
                      color: evmIsActive ? Colors.white : ink,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 40,
            child: Container(
              width: 116,
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.add, size: 18, color: Colors.black),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Add Card',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _WalletCardType { evm, payment }

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});
  @override
  Widget build(BuildContext context) {
    final actions = [
      (Icons.north_east_rounded, 'Send'),
      (Icons.south_west_rounded, 'Request'),
      (Icons.credit_card_outlined, 'Top Up'),
      (Icons.more_horiz_rounded, 'More'),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF171326).withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions
            .map((a) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F2F4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(a.$1, color: Colors.black, size: 22),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      a.$2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.5,
                        color: Color(0xFF22212A),
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const SectionCard({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF171326).withValues(alpha: 0.03),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF171326),
                    ),
                  ),
                  const Text(
                    'View all  ›',
                    style: TextStyle(
                      color: Color(0xFF7C35E8),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              child,
            ],
          ),
        ),
      );
}

class CommunityGrid extends StatelessWidget {
  const CommunityGrid({super.key});
  @override
  Widget build(BuildContext context) {
    final data = [
      ('assets/community_discussions.svg', 'Discussions', 'Engage in topics'),
      ('assets/community_members.svg', 'Members', '12,540+ active'),
      ('assets/community_events.svg', 'Events', 'Join & learn'),
      ('assets/community_resources.svg', 'Resources', 'Guides & tools'),
    ];
    return Row(
      children: data
          .map((d) => Expanded(
                child: CommunityTile(
                  assetPath: d.$1,
                  title: d.$2,
                  subtitle: d.$3,
                ),
              ))
          .toList(),
    );
  }
}

class CommunityTile extends StatelessWidget {
  final String assetPath;
  final String title;
  final String subtitle;

  const CommunityTile({
    super.key,
    required this.assetPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 7),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            SvgPicture.asset(assetPath, width: 28, height: 28),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: Color(0xFF1E1C25),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF77727F),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvestmentRow extends StatelessWidget {
  final String name, type, amount, date;
  final IconData icon;
  const InvestmentRow(this.name, this.type, this.amount, this.date, this.icon,
      {super.key});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: const Color(0xFFEFF8ED),
              child: Icon(icon, size: 18, color: const Color(0xFF39A65A)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color(0xFF171326),
                    ),
                  ),
                  Text(
                    type,
                    style: const TextStyle(
                      color: Color(0xFF77727F),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: Color(0xFF171326),
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xFF77727F),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

class EventRow extends StatelessWidget {
  final String day, month, title, subtitle;
  const EventRow(
      {super.key,
      required this.day,
      required this.month,
      required this.title,
      required this.subtitle});
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F2F8),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  month,
                  style: const TextStyle(
                    color: Color(0xFF7C35E8),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF171326),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF171326),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF77727F),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF7C35E8),
              side: const BorderSide(color: Color(0xFF7C35E8)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: const Text('Register'),
          ),
        ],
      );
}

class InsightsCarousel extends StatefulWidget {
  const InsightsCarousel({super.key});
  @override
  State<InsightsCarousel> createState() => _InsightsCarouselState();
}

class _InsightsCarouselState extends State<InsightsCarousel> {
  final controller = PageController(viewportFraction: .82);
  int page = 0;
  Timer? _timer;

  final articles = const [
    (
      tag: 'REPORT',
      title: 'Global Energy Tech Outlook 2024',
      date: 'May 12, 2024',
      imageUrl:
          'https://images.unsplash.com/photo-1497435334941-8c899ee9e8e9?auto=format&fit=crop&w=1000&q=80',
    ),
    (
      tag: 'INSIGHT',
      title: 'The Rise of Energy Storage Startups',
      date: 'May 9, 2024',
      imageUrl:
          'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?auto=format&fit=crop&w=1000&q=80',
    ),
    (
      tag: 'CASE STUDY',
      title: 'Building Scalable Clean Energy Solutions',
      date: 'May 5, 2024',
      imageUrl:
          'https://images.unsplash.com/photo-1509391366360-2e959784a276?auto=format&fit=crop&w=1000&q=80',
    ),
    (
      tag: 'WEBINAR',
      title: 'Investing in a Sustainable Future',
      date: 'May 1, 2024',
      imageUrl:
          'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=1000&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final nextPage = (page + 1) % articles.length;
      controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Insights & News',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  Text('View All  ›',
                      style: TextStyle(
                          color: Color(0xFF7C35E8),
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                ]),
            const SizedBox(height: 12),
            SizedBox(
              height: 205,
              child: PageView.builder(
                controller: controller,
                itemCount: articles.length,
                onPageChanged: (v) => setState(() => page = v),
                itemBuilder: (_, i) {
                  final a = articles[i];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEAE7EE)),
                        color: const Color(0xFFFCFCFD),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.network(
                                a.imageUrl,
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  height: 100,
                                  color: const Color(0xFFB7D2E9),
                                  child: const Icon(Icons.image_not_supported,
                                      size: 36, color: Colors.white70),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF7C35E8),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Text(a.tag,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w800)),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(a.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12)),
                                    const SizedBox(height: 7),
                                    Text(a.date,
                                        style: const TextStyle(
                                            color: Color(0xFF77727F),
                                            fontSize: 10)),
                                  ]),
                            ),
                          ]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    articles.length,
                    (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: page == i ? 18 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: page == i
                                ? const Color(0xFF7C35E8)
                                : const Color(0xFFD8D4DE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ))),
          ]),
        ),
      );
}

class ActivityRow extends StatelessWidget {
  final String text, time;
  final IconData icon;
  const ActivityRow(this.text, this.time, this.icon, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: const Color(0xFFF0F7ED),
              child: Icon(icon, size: 15, color: const Color(0xFF55A65B)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF171326),
                ),
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF77727F),
              ),
            ),
          ],
        ),
      );
}

class SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;
  const SimplePage({super.key, required this.title, required this.icon});
  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 64, color: const Color(0xFF7C35E8)),
          const SizedBox(height: 16),
          Text(title,
              style:
                  const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Tribes Capital module'),
        ]),
      );
}
