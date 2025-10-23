import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// Jalankan perintah `flutter pub add google_fonts` dan `flutter pub add url_launcher` di terminalmu.

void main() {
  runApp(const KrifiksWebApp());
}

class KrifiksWebApp extends StatelessWidget {
  const KrifiksWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan tema kustom yang terinspirasi dari logo
    final theme = ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: const Color(0xFFFFF8E1), // Warna krem muda
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
          .copyWith(
            displayLarge: GoogleFonts.lilitaOne(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFD32F2F), // Merah tua
              shadows: [
                const Shadow(
                  offset: Offset(3.0, 3.0),
                  blurRadius: 3.0,
                  color: Colors.black26,
                ),
              ],
            ),
            headlineMedium: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333), // Abu-abu gelap
            ),
            bodyLarge: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF555555), // Abu-abu
              height: 1.5,
            ),
          ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFA000), // Warna kuning dari logo
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return MaterialApp(
      title: 'KRIFIKS - Bukan Keripik Biasa',
      theme: theme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Helper function untuk membuka URL generik
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  // Helper function khusus untuk WhatsApp
  void _launchWhatsApp() async {
    // --- GANTI NOMOR INI DENGAN NOMOR WHATSAPP BISNISMU ---
    const String phoneNumber = '6285275088405'; // Contoh: 6281234567890
    const String message = 'Halo Krifiks, saya mau pesan keripiknya dong!';
    final String url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    _launchURL(url);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'KRIFIKS',
          style: GoogleFonts.lilitaOne(
            color: const Color(0xFFD32F2F),
            fontSize: 32,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Hero Section ---
            _buildHeroSection(context, isMobile),
            const SizedBox(height: 50),

            // --- Products Section ---
            _buildSection(
              title: "Produk Andalan Kami",
              content: _buildProductsGrid(isMobile),
            ),
            const SizedBox(height: 30),

            // --- Unique Selling Points Section ---
            _buildSection(
              title: "Kenapa KRIFIKS Beda?",
              content: _buildUSPSection(),
            ),
            const SizedBox(height: 50),

            // --- Gallery Section ---
            _buildSection(
              title: "Galeri KRIFIKS",
              content: _buildGalleryGrid(isMobile),
            ),
            const SizedBox(height: 50),

            // --- Call to Action Section ---
            _buildCTASection(context, isMobile),
          ],
        ),
      ),
      bottomNavigationBar: _buildFooter(context),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      width: double.infinity,
      color: const Color(0xFFD32F2F), // Merah dari logo
      child: Column(
        children: [
          // Ganti 'assets/logo.png' dengan path logo kamu
          // Pastikan sudah ditambahkan di pubspec.yaml
          Image.asset(
            'assets/logo.png',
            height: 150,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.bakery_dining, size: 150, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            "KRIFIKS",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 52 : 72,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "BUKAN KERIPIK BIASA",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFFCA28), // Kuning
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            "Camilan premium dari bahan baku lokal Tebing Tinggi yang diolah dengan rasa kekinian, pas buat Gen-Z!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 4,
            width: 80,
            color: const Color(0xFFFFA000), // Kuning
          ),
          const SizedBox(height: 40),
          content,
        ],
      ),
    );
  }

  Widget _buildProductsGrid(bool isMobile) {
    final products = [
      ProductCard(
        icon: Icons.grass,
        title: "Keripik Singkong",
        description:
            "Tekstur super renyah dengan cita rasa gurih yang jadi kanvas sempurna untuk bumbu luar biasa.",
        color: Colors.orange.shade100,
      ),
      ProductCard(
        icon: Icons.eco,
        title: "Keripik Sukun",
        description:
            "Tekstur unik, sedikit padat namun rapuh, dengan manis alami sukun yang bikin beda.",
        color: Colors.green.shade100,
      ),
      ProductCard(
        icon: Icons.ac_unit, // Placeholder for Banana
        title: "Keripik Pisang",
        description:
            "Manis legit dari pisang pilihan, berpadu harmonis dengan bumbu gurih atau pedas yang tak biasa.",
        color: Colors.yellow.shade100,
      ),
      ProductCard(
        icon: Icons.local_fire_department,
        title: "Varian Rasa Hits",
        description:
            "Balado, Jagung Bakar, Balado Manis, dan Original dengan Saus Glaze (Matcha, Tiramisu, Coklat, Taro, Strawberry).",
        color: Colors.red.shade100,
      ),
    ];

    return isMobile
        ? Column(
            children: products
                .map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: p,
                  ),
                )
                .toList(),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return products[index];
            },
          );
  }

  Widget _buildUSPSection() {
    final usps = [
      USPItem(
        icon: Icons.location_on,
        title: "Bahan Baku Lokal Terbaik",
        description: "Dari petani Tebing Tinggi, menjamin rasa autentik.",
      ),
      USPItem(
        icon: Icons.brush,
        title: "Inovasi Rasa Tak Biasa",
        description:
            "Original dengan saus glaze manis, pengalaman ngemil baru!",
      ),
      USPItem(
        icon: Icons.star,
        title: "Kerenyahan Terjamin",
        description:
            "Teknik penggoreo.ngan modern, renyah tanpa minyak berlebih.",
      ),
      USPItem(
        icon: Icons.health_and_safety,
        title: "100% Tanpa Pengawet",
        description: "Aman, sehat, dan cocok untuk ngemil kapan saja.",
      ),
    ];

    return Wrap(
      spacing: 40.0,
      runSpacing: 40.0,
      alignment: WrapAlignment.center,
      children: usps,
    );
  }

  Widget _buildGalleryGrid(bool isMobile) {
    final galleryItems = [
      GalleryItem(
        imagePath: 'assets/produk_balado.png',
        title: 'Keripik Balado Pedas',
      ),
      GalleryItem(
        imagePath: 'assets/produk_jagung.png',
        title: 'Keripik Jagung Bakar',
      ),
      GalleryItem(
        imagePath: 'assets/produk_glaze.png',
        title: 'Original dengan Saus Glaze',
      ),
      GalleryItem(
        imagePath: 'assets/produk_kemasan.png',
        title: 'Kemasan Kekinian',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 4,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.8,
      ),
      itemCount: galleryItems.length,
      itemBuilder: (context, index) {
        return GalleryImageCard(
          imagePath: galleryItems[index].imagePath,
          title: galleryItems[index].title,
        );
      },
    );
  }

  Widget _buildCTASection(BuildContext context, bool isMobile) {
    final buttons = [
      ElevatedButton.icon(
        icon: const Icon(Icons.chat),
        onPressed: _launchWhatsApp,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF25D366),
        ),
        label: const Text('Pesan via WhatsApp'),
      ),
      const SizedBox(height: 15, width: 20),
      ElevatedButton(
        onPressed: () => _launchURL('https://www.instagram.com/krifiks.id'),
        child: const Text('Cek Instagram @krifiks.id'),
      ),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      width: double.infinity,
      color: const Color(0xFFF5F5F5),
      child: Column(
        children: [
          Text("Penasaran?", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          Text(
            "Langsung kepoin dan pesan KRIFIKS di media sosial kami. Jangan sampai kehabisan!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 30),
          isMobile
              ? Column(children: buttons)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buttons,
                ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF333333),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chat, color: Colors.white),
                onPressed: _launchWhatsApp,
                tooltip: 'WhatsApp',
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () =>
                    _launchURL('https://www.instagram.com/krifiks.id'),
                tooltip: 'Instagram',
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.music_note, color: Colors.white),
                onPressed: () =>
                    _launchURL('https://www.tiktok.com/@krifiks.id'),
                tooltip: 'TikTok',
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "© 2025 KRIFIKS - Tebing Tinggi, Sumatera Utara.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Data class untuk item galeri
class GalleryItem {
  final String imagePath;
  final String title;

  GalleryItem({required this.imagePath, required this.title});
}

// Widget kustom untuk kartu gambar di galeri
class GalleryImageCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const GalleryImageCard({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 40,
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            "Gagal memuat",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget kustom untuk kartu produk
class ProductCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const ProductCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: color,
              child: Icon(icon, size: 30, color: Colors.black54),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget kustom untuk item Keunggulan
class USPItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const USPItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          Icon(icon, size: 40, color: const Color(0xFFFFA000)),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color(0xFF555555)),
          ),
        ],
      ),
    );
  }
}
