import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../weather/data/services/weather_service.dart';

class LocationView extends StatefulWidget {
  static const String routeName = '/location';

  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  final TransformationController _transformationController =
      TransformationController();

  double _zoomLevel = 1.0;
  String _selectedPlace = 'Zagazig, Egypt';
  String _selectedCategory = 'City Center & Cultural Hub';
  bool _isLoadingLocation = true;
  Offset _pinPosition = const Offset(0.52, 0.48);

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
    _transformationController.addListener(_onZoomChanged);
  }

  void _onZoomChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    setState(() {
      _zoomLevel = scale;
    });
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      final weather = await WeatherService().fetchWeather();
      if (mounted && weather != null) {
        setState(() {
          _selectedPlace = '${weather.cityName}, ${weather.country}';
          _isLoadingLocation = false;
        });
      } else if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    }
  }

  void _zoomIn() {
    final double newScale = (_zoomLevel * 1.35).clamp(0.4, 4.0);
    _transformationController.value = Matrix4.identity()..scale(newScale);
  }

  void _zoomOut() {
    final double newScale = (_zoomLevel / 1.35).clamp(0.4, 4.0);
    _transformationController.value = Matrix4.identity()..scale(newScale);
  }

  void _recenter() {
    _transformationController.value = Matrix4.identity();
    setState(() {
      _zoomLevel = 1.0;
      _pinPosition = const Offset(0.52, 0.48);
    });
  }

  void _handleMapTap(TapDownDetails details, Size size) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final localPos = details.localPosition;
      final dx = (localPos.dx / size.width).clamp(0.1, 0.9);
      final dy = (localPos.dy / size.height).clamp(0.1, 0.9);

      setState(() {
        _pinPosition = Offset(dx, dy);

        if (_zoomLevel < 0.7) {
          if (dy < 0.35) {
            _selectedPlace = 'Alexandria / Mediterranean Coast';
            _selectedCategory = 'Coastal Port City';
          } else if (dx > 0.6) {
            _selectedPlace = 'Red Sea / Sinai Peninsula';
            _selectedCategory = 'Resort & Marine Area';
          } else {
            _selectedPlace = 'Cairo - Zagazig Region, Egypt';
            _selectedCategory = 'Capital & Nile Delta Hub';
          }
        } else if (_zoomLevel > 1.8) {
          if (dy < 0.4) {
            _selectedPlace = 'San Cosme Metro District';
            _selectedCategory = 'Historic Metro Station';
          } else if (dx < 0.4) {
            _selectedPlace = 'Melchor Ocampo Main Avenue';
            _selectedCategory = 'Major City Highway';
          } else {
            _selectedPlace = 'Juárez Shopping Plaza';
            _selectedCategory = 'Shopping & Dining';
          }
        } else {
          _selectedPlace = 'Zagazig City Center';
          _selectedCategory = 'Commercial & Cultural Hub';
        }
      });

      _showPlaceDetailsBottomSheet();
    }
  }

  void _showPlaceDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 16, offset: Offset(0, -4)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedPlace,
                          style: const TextStyle(
                            fontFamily: 'Lexend_Deca',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _selectedCategory,
                          style: const TextStyle(
                            fontFamily: 'Lexend_Deca',
                            fontSize: 13,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        Text(
                          '4.8',
                          style: TextStyle(
                            fontFamily: 'Lexend_Deca',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Icon(Icons.access_time_rounded,
                      size: 16, color: Colors.green),
                  SizedBox(width: 6),
                  Text(
                    'Open Now • Closes 10:00 PM',
                    style: TextStyle(
                      fontFamily: 'Lexend_Deca',
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Directions',
                      icon: Icons.directions_rounded,
                      onPressed: () => Navigator.of(context).pop(),
                      horizontalPadding: 16,
                      verticalPadding: 12,
                      borderRadius: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  CustomButton(
                    text: 'Call',
                    icon: Icons.call_rounded,
                    backgroundColor: Colors.grey.shade100,
                    textColor: AppColors.primaryBlue,
                    onPressed: () => Navigator.of(context).pop(),
                    horizontalPadding: 20,
                    verticalPadding: 12,
                    borderRadius: 20,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onZoomChanged);
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final mapColor =
        _zoomLevel < 0.7 ? const Color(0xFFA2DAF2) : const Color(0xFFF4F3F0);

    return Scaffold(
      backgroundColor: mapColor,
      body: Stack(
        children: [
          // 1. Full Screen Zoomable & Pannable Map
          GestureDetector(
            onTapDown: (details) => _handleMapTap(details, screenSize),
            child: InteractiveViewer(
              transformationController: _transformationController,
              minScale: 0.4,
              maxScale: 4.0,
              boundaryMargin: const EdgeInsets.all(500),
              child: SizedBox(
                width: screenSize.width,
                height: screenSize.height,
                child: CustomPaint(
                  painter: DetailedGoogleMapPainter(zoomLevel: _zoomLevel),
                  child: Stack(
                    children: [
                      if (_zoomLevel >= 0.7) ...[
                        const Positioned(
                          top: 140,
                          left: 120,
                          child: _MapLabel(
                              text: 'SAN RAFAEL',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8C827A)),
                        ),
                        const Positioned(
                          top: 240,
                          left: 18,
                          child: _MapLabel(
                              text: 'Cto. Interior Melchor Ocampo',
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFD97724)),
                        ),
                        const Positioned(
                          top: 310,
                          left: 45,
                          child: _MapLabel(
                              text: 'CUAUHTÉMOC',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8C827A)),
                        ),
                        const Positioned(
                          top: 410,
                          right: 70,
                          child: _MapLabel(
                              text: 'JUÁREZ',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8C827A)),
                        ),

                        // Landmark Badges
                        Positioned(
                          top: 180,
                          left: 50,
                          child: _buildPlaceBadge(
                              '🏛️ UVM Campus', Colors.brown.shade400),
                        ),
                        Positioned(
                          top: 270,
                          right: 60,
                          child: _buildPlaceBadge(
                              '🏨 Marriott Hotel', Colors.blue.shade700),
                        ),
                        Positioned(
                          top: 360,
                          left: 130,
                          child: _buildPlaceBadge(
                              '☕ Coffee Hub', Colors.orange.shade700),
                        ),
                      ],

                      // Detailed World / Country / City Labels when Zoomed Out
                      if (_zoomLevel < 0.7) ...[
                        const Positioned(
                          top: 80,
                          left: 60,
                          child: _MapLabel(
                              text: 'MEDITERRANEAN SEA',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1565C0)),
                        ),
                        const Positioned(
                          top: 140,
                          left: 140,
                          child: _MapLabel(
                              text: 'ALEXANDRIA',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF37474F)),
                        ),
                        const Positioned(
                          top: 220,
                          left: 130,
                          child: _MapLabel(
                              text: 'CAIRO / ZAGAZIG',
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFD84315)),
                        ),
                        const Positioned(
                          top: 290,
                          left: 110,
                          child: _MapLabel(
                              text: 'EGYPT',
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF4E342E)),
                        ),
                        const Positioned(
                          top: 360,
                          right: 30,
                          child: _MapLabel(
                              text: 'RED SEA',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1565C0)),
                        ),
                        const Positioned(
                          top: 220,
                          right: 20,
                          child: _MapLabel(
                              text: 'SAUDI ARABIA',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4E342E)),
                        ),
                      ],

                      // Yellow Star Marker
                      Positioned(
                        top: screenSize.height * 0.45,
                        left: screenSize.width * 0.51,
                        child: GestureDetector(
                          onTap: _showPlaceDetailsBottomSheet,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFC107),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2)),
                              ],
                            ),
                            child: const Icon(Icons.star_rounded,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ),

                      // Food Marker
                      Positioned(
                        top: screenSize.height * 0.72,
                        left: screenSize.width * 0.72,
                        child: GestureDetector(
                          onTap: _showPlaceDetailsBottomSheet,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFC107),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.restaurant_rounded,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ),

                      // Bar Marker
                      Positioned(
                        top: screenSize.height * 0.68,
                        left: screenSize.width * 0.82,
                        child: GestureDetector(
                          onTap: _showPlaceDetailsBottomSheet,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF0288D1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.local_bar_rounded,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ),

                      // Dynamic Selected Pin Positioned on Map Tap
                      Positioned(
                        top: screenSize.height * _pinPosition.dy - 20,
                        left: screenSize.width * _pinPosition.dx - 20,
                        child: GestureDetector(
                          onTap: _showPlaceDetailsBottomSheet,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0x33673AB7),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0x66673AB7), width: 2),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF673AB7),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 10,
                                      offset: Offset(0, 4)),
                                ],
                              ),
                              child: const Icon(Icons.shopping_bag_rounded,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 2. Floating Zoom Control Buttons
          Positioned(
            right: 16,
            top: 140,
            child: Column(
              children: [
                _buildMapControlButton(
                  icon: Icons.add_rounded,
                  onTap: _zoomIn,
                  tooltip: 'Zoom In',
                ),
                const SizedBox(height: 8),
                _buildMapControlButton(
                  icon: Icons.remove_rounded,
                  onTap: _zoomOut,
                  tooltip: 'Zoom Out',
                ),
                const SizedBox(height: 8),
                _buildMapControlButton(
                  icon: Icons.my_location_rounded,
                  onTap: _recenter,
                  tooltip: 'Recenter',
                  iconColor: AppColors.primaryBlue,
                ),
              ],
            ),
          ),

          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: _showPlaceDetailsBottomSheet,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 4)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.primaryBlue,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Current Location',
                                style: TextStyle(
                                  fontFamily: 'Lexend_Deca',
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                'Zoom: ${_zoomLevel.toStringAsFixed(1)}x',
                                style: const TextStyle(
                                  fontFamily: 'Lexend_Deca',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          _isLoadingLocation
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primaryBlue,
                                  ),
                                )
                              : Text(
                                  _selectedPlace,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Lexend_Deca',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
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

          Positioned(
            bottom: 36,
            left: 0,
            right: 0,
            child: Center(
              child: CustomButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(HomeView.routeName);
                },
                horizontalPadding: 48,
                verticalPadding: 16,
                borderRadius: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Lexend_Deca',
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildMapControlButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
    Color iconColor = AppColors.textPrimary,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor, size: 22),
        onPressed: onTap,
        tooltip: tooltip,
      ),
    );
  }
}

class _MapLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const _MapLabel({
    required this.text,
    this.fontSize = 11,
    this.fontWeight = FontWeight.normal,
    this.color = const Color(0xFF757575),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Lexend_Deca',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: 0.8,
      ),
    );
  }
}

class DetailedGoogleMapPainter extends CustomPainter {
  final double zoomLevel;

  DetailedGoogleMapPainter({required this.zoomLevel});

  @override
  void paint(Canvas canvas, Size size) {
    if (zoomLevel < 0.7) {
      _paintWorldContinentView(canvas, size);
    } else {
      _paintStreetLevelView(canvas, size);
    }
  }

  void _paintWorldContinentView(Canvas canvas, Size size) {
    // 1. Ocean Blue Background
    final Paint oceanPaint = Paint()..color = const Color(0xFFA2DAF2);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), oceanPaint);

    final Paint landPaint = Paint()..color = const Color(0xFFEDEAD8);
    final Paint borderPaint = Paint()
      ..color = const Color(0xFFC0BEB5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    Path africa = Path();
    africa.moveTo(0, size.height * 0.05);
    africa.lineTo(size.width * 0.8, size.height * 0.05); // Mediterranean coastline
    africa.lineTo(size.width * 0.95, size.height * 0.35); // Suez & Red Sea coast
    africa.lineTo(size.width * 0.75, size.height * 0.95); // East Africa
    africa.lineTo(0, size.height * 0.95);
    africa.close();

    canvas.drawPath(africa, landPaint);
    canvas.drawPath(africa, borderPaint);

    Path arabia = Path();
    arabia.moveTo(size.width * 0.82, size.height * 0.15);
    arabia.lineTo(size.width, size.height * 0.2);
    arabia.lineTo(size.width, size.height * 0.7);
    arabia.lineTo(size.width * 0.85, size.height * 0.5);
    arabia.close();

    canvas.drawPath(arabia, landPaint);
    canvas.drawPath(arabia, borderPaint);

    final Paint deltaPaint = Paint()..color = const Color(0xFFC5E8C4);
    Path delta = Path();
    delta.moveTo(size.width * 0.3, size.height * 0.12);
    delta.lineTo(size.width * 0.5, size.height * 0.12);
    delta.lineTo(size.width * 0.42, size.height * 0.25);
    delta.close();
    canvas.drawPath(delta, deltaPaint);

    final Paint nilePaint = Paint()
      ..color = const Color(0xFFA2DAF2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    Path nile = Path();
    nile.moveTo(size.width * 0.42, size.height * 0.22);
    nile.lineTo(size.width * 0.4, size.height * 0.45);
    nile.lineTo(size.width * 0.45, size.height * 0.75);

    canvas.drawPath(nile, nilePaint);

    final Paint cityPinPaint = Paint()..color = const Color(0xFFD84315);
    canvas.drawCircle(Offset(size.width * 0.41, size.height * 0.25), 6, cityPinPaint); // Cairo / Zagazig
    canvas.drawCircle(Offset(size.width * 0.32, size.height * 0.14), 5, cityPinPaint); // Alexandria
  }

  void _paintStreetLevelView(Canvas canvas, Size size) {
    final Paint bgPaint = Paint()..color = const Color(0xFFF4F3F0);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final Paint buildingPaint = Paint()..color = const Color(0xFFE8E5DF);
    final Paint buildingOutline = Paint()
      ..color = const Color(0xFFDDD9D1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final List<Rect> buildingBlocks = [
      Rect.fromLTWH(30, 80, 80, 50),
      Rect.fromLTWH(140, 90, 90, 60),
      Rect.fromLTWH(260, 80, 70, 70),
      Rect.fromLTWH(40, 190, 75, 55),
      Rect.fromLTWH(160, 200, 80, 65),
      Rect.fromLTWH(270, 210, 65, 60),
      Rect.fromLTWH(30, 320, 85, 60),
      Rect.fromLTWH(150, 330, 90, 70),
      Rect.fromLTWH(260, 340, 80, 65),
    ];

    for (var rect in buildingBlocks) {
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(6)),
          buildingPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(6)),
          buildingOutline);
    }

    final Paint waterPaint = Paint()..color = const Color(0xFFA2DAF2);
    Path river = Path();
    river.moveTo(0, size.height * 0.08);
    river.cubicTo(size.width * 0.3, size.height * 0.12, size.width * 0.6,
        size.height * 0.04, size.width, size.height * 0.1);
    river.lineTo(size.width, 0);
    river.lineTo(0, 0);
    canvas.drawPath(river, waterPaint);

    final Paint parkPaint = Paint()..color = const Color(0xFFC5E8C4);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(20, size.height * 0.18, size.width * 0.38, 90),
        const Radius.circular(8),
      ),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.58, size.height * 0.22, 110, 150),
        const Radius.circular(8),
      ),
      parkPaint,
    );

    final Paint streetBorder = Paint()
      ..color = const Color(0xFFD6D6D6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    final Paint streetFill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    Path streetsPath = Path();

    for (double i = -100; i < size.height + 200; i += 65) {
      streetsPath.moveTo(0, i);
      streetsPath.lineTo(size.width, i + size.width * 0.38);
    }

    for (double i = -100; i < size.width + 200; i += 75) {
      streetsPath.moveTo(i, 0);
      streetsPath.lineTo(i - size.height * 0.45, size.height);
    }

    canvas.drawPath(streetsPath, streetBorder);
    canvas.drawPath(streetsPath, streetFill);

    final Paint highwayBorder = Paint()
      ..color = const Color(0xFFE59836)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    final Paint highwayFill = Paint()
      ..color = const Color(0xFFFFD166)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    Path highway = Path();
    highway.moveTo(size.width * 0.65, 0);
    highway.lineTo(size.width * 0.15, size.height * 0.72);
    highway.lineTo(0, size.height * 0.92);

    canvas.drawPath(highway, highwayBorder);
    canvas.drawPath(highway, highwayFill);

    Path avenue = Path();
    avenue.moveTo(0, size.height * 0.86);
    avenue.lineTo(size.width, size.height * 0.64);

    canvas.drawPath(avenue, highwayBorder);
    canvas.drawPath(avenue, highwayFill);
  }

  @override
  bool shouldRepaint(covariant DetailedGoogleMapPainter oldDelegate) {
    return oldDelegate.zoomLevel != zoomLevel;
  }
}
