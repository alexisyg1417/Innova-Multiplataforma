import 'package:flutter/material.dart';

void main() {
  runApp(const InnovaMultiApp());
}

class InnovaMultiApp extends StatelessWidget {
  const InnovaMultiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'INNOVA Multiplataforma',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F6F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF152A3A),
          primary: const Color(0xFF152A3A),
          secondary: const Color(0xFFD3A953),
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const MainShell(),
    );
  }
}

class Property {
  final String name;
  final String location;
  final String operation;
  final int price;
  final int rooms;
  final int baths;
  final int parking;
  final Color accent;
  final String description;

  const Property({
    required this.name,
    required this.location,
    required this.operation,
    required this.price,
    required this.rooms,
    required this.baths,
    required this.parking,
    required this.accent,
    required this.description,
  });
}

const sampleProperties = <Property>[
  Property(
    name: 'Casa Familiar Cholula',
    location: 'San Pedro Cholula, Puebla',
    operation: 'Venta',
    price: 3250000,
    rooms: 4,
    baths: 2,
    parking: 2,
    accent: Color(0xFFD3A953),
    description:
        'Casa familiar con distribución funcional, jardín frontal, cochera y espacios iluminados. Ideal para una familia que busca una zona tranquila y conectada.',
  ),
  Property(
    name: 'Residencia La Paz',
    location: 'La Paz, Puebla',
    operation: 'Renta',
    price: 25000,
    rooms: 5,
    baths: 3,
    parking: 2,
    accent: Color(0xFF6E879A),
    description:
        'Residencia amplia con acabados contemporáneos, área social y habitaciones con excelente iluminación natural.',
  ),
  Property(
    name: 'Departamento Angelópolis',
    location: 'Angelópolis, Puebla',
    operation: 'Venta',
    price: 2180000,
    rooms: 2,
    baths: 2,
    parking: 1,
    accent: Color(0xFFB88563),
    description:
        'Departamento moderno con acceso a servicios, estacionamiento y ubicación estratégica para movilidad urbana.',
  ),
  Property(
    name: 'Loft Centro Histórico',
    location: 'Centro, Puebla',
    operation: 'Renta',
    price: 13000,
    rooms: 1,
    baths: 1,
    parking: 0,
    accent: Color(0xFF7C8573),
    description:
        'Loft compacto para estudiantes o profesionistas, cerca de servicios, transporte y zonas culturales.',
  ),
];

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  final Set<int> favorites = {0};

  void toggleFavorite(int propertyIndex) {
    setState(() {
      if (!favorites.add(propertyIndex)) favorites.remove(propertyIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;
        final pages = <Widget>[
          HomePage(
            onOpenCatalog: () => setState(() => index = 1),
            onOpenProperty: (p) => _openProperty(context, p),
          ),
          CatalogPage(
            favorites: favorites,
            onToggleFavorite: toggleFavorite,
            onOpenProperty: (p) => _openProperty(context, p),
          ),
          const AppointmentsPage(),
          FavoritesPage(
            favorites: favorites,
            onToggleFavorite: toggleFavorite,
            onOpenProperty: (p) => _openProperty(context, p),
          ),
          const ProfilePage(),
        ];

        return Scaffold(
          body: Row(
            children: [
              if (wide)
                NavigationRail(
                  extended: constraints.maxWidth >= 1200,
                  backgroundColor: const Color(0xFF152A3A),
                  selectedIconTheme: const IconThemeData(color: Color(0xFFD3A953)),
                  unselectedIconTheme: const IconThemeData(color: Colors.white70),
                  selectedLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 24),
                    child: _Brand(compact: constraints.maxWidth < 1200),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Inicio'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.apartment_outlined),
                      selectedIcon: Icon(Icons.apartment),
                      label: Text('Catálogo'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.calendar_month_outlined),
                      selectedIcon: Icon(Icons.calendar_month),
                      label: Text('Citas'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite_border),
                      selectedIcon: Icon(Icons.favorite),
                      label: Text('Favoritos'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Perfil'),
                    ),
                  ],
                  selectedIndex: index,
                  onDestinationSelected: (value) => setState(() => index = value),
                ),
              Expanded(
                child: SafeArea(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: KeyedSubtree(key: ValueKey(index), child: pages[index]),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: wide
              ? null
              : NavigationBar(
                  selectedIndex: index,
                  onDestinationSelected: (value) => setState(() => index = value),
                  destinations: const [
                    NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
                    NavigationDestination(icon: Icon(Icons.apartment_outlined), selectedIcon: Icon(Icons.apartment), label: 'Catálogo'),
                    NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Citas'),
                    NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Favoritos'),
                    NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
                  ],
                ),
        );
      },
    );
  }

  void _openProperty(BuildContext context, Property property) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PropertyDetailPage(property: property)),
    );
  }
}

class _Brand extends StatelessWidget {
  final bool compact;
  const _Brand({this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFD3A953),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.apartment, color: Color(0xFF152A3A)),
        ),
        if (!compact) ...[
          const SizedBox(width: 12),
          const Text(
            'INNOVA',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: 2),
          ),
        ],
      ],
    );
  }
}

class PageFrame extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;

  const PageFrame({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxWidth > 1000 ? 44.0 : 22.0;
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(padding, 28, padding, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    eyebrow.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 2.2, color: Color(0xFF9B7A36)),
                  ),
                  if (constraints.maxWidth < 900)
                    const Text('INNOVA', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 800 ? 44 : 34,
                  height: 1.03,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF152A3A),
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Text(subtitle, style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF64727C))),
              ),
              const SizedBox(height: 28),
              child,
            ],
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onOpenCatalog;
  final void Function(Property) onOpenProperty;
  const HomePage({super.key, required this.onOpenCatalog, required this.onOpenProperty});

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      eyebrow: 'INNOVA multiplataforma',
      title: 'Tu próximo hogar, en cualquier dispositivo.',
      subtitle: 'Una misma experiencia inmobiliaria adaptada a móvil, web y escritorio desde una sola base de código.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 14,
                runSpacing: 14,
                children: const [
                  _StatCard(value: '120+', label: 'Propiedades', icon: Icons.apartment),
                  _StatCard(value: '45+', label: 'Cierres al mes', icon: Icons.handshake_outlined),
                  _StatCard(value: '3', label: 'Plataformas', icon: Icons.devices),
                ],
              );
            },
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: onOpenCatalog,
            icon: const Icon(Icons.search),
            label: const Text('Explorar catálogo'),
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18)),
          ),
          const SizedBox(height: 34),
          const Text('Propiedades destacadas', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          ResponsivePropertyGrid(
            properties: sampleProperties.take(3).toList(),
            onOpen: onOpenProperty,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  const _StatCard({required this.value, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: const Color(0xFFF0E3C3), child: Icon(icon, color: const Color(0xFF9B7A36))),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            Text(label, style: const TextStyle(color: Color(0xFF64727C))),
          ]),
        ],
      ),
    );
  }
}

class CatalogPage extends StatefulWidget {
  final Set<int> favorites;
  final void Function(int) onToggleFavorite;
  final void Function(Property) onOpenProperty;
  const CatalogPage({super.key, required this.favorites, required this.onToggleFavorite, required this.onOpenProperty});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String query = '';
  String filter = 'Todas';

  @override
  Widget build(BuildContext context) {
    final visible = <MapEntry<int, Property>>[];
    for (var i = 0; i < sampleProperties.length; i++) {
      final p = sampleProperties[i];
      final queryOk = query.isEmpty || p.name.toLowerCase().contains(query.toLowerCase()) || p.location.toLowerCase().contains(query.toLowerCase());
      final filterOk = filter == 'Todas' || p.operation == filter;
      if (queryOk && filterOk) visible.add(MapEntry(i, p));
    }

    return PageFrame(
      eyebrow: 'Catálogo',
      title: 'Encuentra tu propiedad ideal',
      subtitle: 'Busca por nombre o ubicación y filtra por operación. La cuadrícula cambia automáticamente según el ancho disponible.',
      child: Column(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            final vertical = constraints.maxWidth < 650;
            final search = TextField(
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Buscar por zona o propiedad'),
              onChanged: (value) => setState(() => query = value),
            );
            final chips = Wrap(
              spacing: 8,
              children: ['Todas', 'Venta', 'Renta'].map((item) {
                return ChoiceChip(
                  label: Text(item),
                  selected: filter == item,
                  onSelected: (_) => setState(() => filter = item),
                );
              }).toList(),
            );
            if (vertical) {
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [search, const SizedBox(height: 12), chips]);
            }
            return Row(children: [Expanded(child: search), const SizedBox(width: 16), chips]);
          }),
          const SizedBox(height: 24),
          LayoutBuilder(builder: (context, constraints) {
            int count = 1;
            if (constraints.maxWidth >= 1100) count = 3;
            else if (constraints.maxWidth >= 700) count = 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visible.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: count,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: count == 1 ? 1.42 : 0.98,
              ),
              itemBuilder: (context, i) {
                final entry = visible[i];
                return PropertyCard(
                  property: entry.value,
                  favorite: widget.favorites.contains(entry.key),
                  onFavorite: () => widget.onToggleFavorite(entry.key),
                  onTap: () => widget.onOpenProperty(entry.value),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class ResponsivePropertyGrid extends StatelessWidget {
  final List<Property> properties;
  final void Function(Property) onOpen;
  const ResponsivePropertyGrid({super.key, required this.properties, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int count = 1;
      if (constraints.maxWidth >= 1100) count = 3;
      else if (constraints.maxWidth >= 700) count = 2;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: properties.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: count == 1 ? 1.42 : 0.98,
        ),
        itemBuilder: (context, i) => PropertyCard(property: properties[i], onTap: () => onOpen(properties[i])),
      );
    });
  }
}

class PropertyCard extends StatelessWidget {
  final Property property;
  final bool favorite;
  final VoidCallback? onFavorite;
  final VoidCallback onTap;
  const PropertyCard({super.key, required this.property, this.favorite = false, this.onFavorite, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  PropertyVisual(property: property),
                  Positioned(
                    left: 14,
                    top: 14,
                    child: _Pill(text: property.operation, color: property.operation == 'Venta' ? const Color(0xFF1769FF) : const Color(0xFF198754)),
                  ),
                  if (onFavorite != null)
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton.filledTonal(
                        onPressed: onFavorite,
                        icon: Icon(favorite ? Icons.favorite : Icons.favorite_border, color: favorite ? Colors.red : null),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(property.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Row(children: [const Icon(Icons.location_on_outlined, size: 17, color: Colors.redAccent), const SizedBox(width: 4), Expanded(child: Text(property.location, maxLines: 1, overflow: TextOverflow.ellipsis))]),
                  const SizedBox(height: 10),
                  Text('\$${formatPrice(property.price)} MXN', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF152A3A))),
                  const SizedBox(height: 10),
                  Row(children: [
                    _Spec(icon: Icons.bed_outlined, text: '${property.rooms}'),
                    const SizedBox(width: 14),
                    _Spec(icon: Icons.bathtub_outlined, text: '${property.baths}'),
                    const SizedBox(width: 14),
                    _Spec(icon: Icons.directions_car_outlined, text: '${property.parking}'),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyVisual extends StatelessWidget {
  final Property property;
  const PropertyVisual({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [property.accent.withValues(alpha: 0.95), const Color(0xFF152A3A)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(right: 22, bottom: 15, child: Icon(Icons.house_rounded, size: 92, color: Colors.white.withValues(alpha: 0.18))),
          Positioned(left: 18, bottom: 18, child: Text('INNOVA', style: TextStyle(color: Colors.white.withValues(alpha: 0.72), fontWeight: FontWeight.w900, letterSpacing: 2))),
        ],
      ),
    );
  }
}

class PropertyDetailPage extends StatelessWidget {
  final Property property;
  const PropertyDetailPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de propiedad')),
      body: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 850;
        final visual = ClipRRect(borderRadius: BorderRadius.circular(24), child: SizedBox(height: wide ? 520 : 300, child: PropertyVisual(property: property)));
        final info = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Pill(text: property.operation, color: property.operation == 'Venta' ? const Color(0xFF1769FF) : const Color(0xFF198754)),
            const SizedBox(height: 14),
            Text(property.name, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: Color(0xFF152A3A))),
            const SizedBox(height: 8),
            Text(property.location, style: const TextStyle(fontSize: 16, color: Color(0xFF64727C))),
            const SizedBox(height: 16),
            Text('\$${formatPrice(property.price)} MXN', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            const SizedBox(height: 18),
            Wrap(spacing: 18, runSpacing: 12, children: [
              _Spec(icon: Icons.bed_outlined, text: '${property.rooms} habitaciones'),
              _Spec(icon: Icons.bathtub_outlined, text: '${property.baths} baños'),
              _Spec(icon: Icons.directions_car_outlined, text: '${property.parking} cochera'),
            ]),
            const SizedBox(height: 22),
            Text(property.description, style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 24),
            Wrap(spacing: 12, runSpacing: 12, children: [
              FilledButton.icon(onPressed: () => _showMessage(context, 'Visita agendada para esta propiedad.'), icon: const Icon(Icons.calendar_month), label: const Text('Agendar visita')),
              OutlinedButton.icon(onPressed: () => _showMessage(context, 'Perfil del vendedor abierto.'), icon: const Icon(Icons.person_outline), label: const Text('Ver vendedor')),
            ]),
          ],
        );
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: wide
              ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(flex: 6, child: visual), const SizedBox(width: 28), Expanded(flex: 4, child: info)])
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [visual, const SizedBox(height: 22), info]),
        );
      }),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      eyebrow: 'Agenda',
      title: 'Citas programadas',
      subtitle: 'Consulta próximas visitas y su estado desde cualquier plataforma.',
      child: Column(
        children: const [
          AppointmentTile(property: 'Casa Familiar Cholula', date: '28 sep · 12:30', status: 'Confirmada', statusColor: Color(0xFF198754)),
          SizedBox(height: 12),
          AppointmentTile(property: 'Departamento Angelópolis', date: '30 sep · 16:00', status: 'Pendiente', statusColor: Color(0xFFD3A953)),
        ],
      ),
    );
  }
}

class AppointmentTile extends StatelessWidget {
  final String property;
  final String date;
  final String status;
  final Color statusColor;
  const AppointmentTile({super.key, required this.property, required this.date, required this.status, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const CircleAvatar(radius: 26, backgroundColor: Color(0xFFF0E3C3), child: Icon(Icons.calendar_month, color: Color(0xFF9B7A36))),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(property, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)), const SizedBox(height: 4), Text(date, style: const TextStyle(color: Color(0xFF64727C)))])),
          _Pill(text: status, color: statusColor),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final Set<int> favorites;
  final void Function(int) onToggleFavorite;
  final void Function(Property) onOpenProperty;
  const FavoritesPage({super.key, required this.favorites, required this.onToggleFavorite, required this.onOpenProperty});

  @override
  Widget build(BuildContext context) {
    final items = favorites.toList()..sort();
    return PageFrame(
      eyebrow: 'Favoritos',
      title: 'Tus propiedades guardadas',
      subtitle: 'La sección conserva las propiedades marcadas durante la sesión del prototipo.',
      child: items.isEmpty
          ? const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('Aún no tienes propiedades favoritas.')))
          : ResponsivePropertyGrid(properties: items.map((i) => sampleProperties[i]).toList(), onOpen: onOpenProperty),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      eyebrow: 'Perfil',
      title: 'Alexis Yáñez',
      subtitle: 'Panel de usuario del prototipo multiplataforma.',
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(leading: Icon(Icons.person_outline), title: Text('Rol'), subtitle: Text('Comprador / usuario')), 
            Divider(),
            ListTile(leading: Icon(Icons.favorite_border), title: Text('Favoritos'), subtitle: Text('Consulta tus propiedades guardadas')), 
            Divider(),
            ListTile(leading: Icon(Icons.calendar_month_outlined), title: Text('Citas'), subtitle: Text('Administra visitas programadas')), 
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color color;
  const _Pill({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(99)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
    );
  }
}

class _Spec extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Spec({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 18, color: const Color(0xFF64727C)), const SizedBox(width: 5), Text(text)]);
  }
}

String formatPrice(int value) {
  final s = value.toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
    b.write(s[i]);
  }
  return b.toString();
}
