import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';

const Color fondo = Color(0xFFF3F6FC);
const Color azul = Color(0xFF2563EB);
const Color oscuro = Color(0xFF172554);

void main() {
  runApp(const CajaHerramientasApp());
}

class CajaHerramientasApp extends StatelessWidget {
  const CajaHerramientasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caja de Herramientas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: fondo,
        colorScheme: ColorScheme.fromSeed(seedColor: azul),
        appBarTheme: const AppBarTheme(
          backgroundColor: fondo,
          foregroundColor: oscuro,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const InicioScreen(),
    );
  }
}

// MENÚ PRINCIPAL

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  static const herramientas = [
    {
      'titulo': 'Predecir género',
      'detalle': 'Predicción a partir de un nombre',
      'icono': Icons.wc,
      'color': Color(0xFFEC4899),
    },
    {
      'titulo': 'Usuario aleatorio',
      'detalle': 'Genera un perfil de persona',
      'icono': Icons.person_search,
      'color': Color(0xFF8B5CF6),
    },
    {
      'titulo': 'Universidades',
      'detalle': 'Busca universidades por país',
      'icono': Icons.school,
      'color': Color(0xFF0D9488),
    },
    {
      'titulo': 'Clima en RD',
      'detalle': 'Consulta el tiempo actual',
      'icono': Icons.cloud,
      'color': Color(0xFF0284C7),
    },
    {
      'titulo': 'Pokémon',
      'detalle': 'Datos, habilidades y sonido',
      'icono': Icons.catching_pokemon,
      'color': Color(0xFFF59E0B),
    },
    {
      'titulo': 'Noticias WordPress',
      'detalle': 'Últimas publicaciones',
      'icono': Icons.newspaper,
      'color': Color(0xFF6366F1),
    },
    {
      'titulo': 'Acerca de',
      'detalle': 'Perfil y contacto',
      'icono': Icons.account_circle,
      'color': Color(0xFF475569),
    },
  ];

  void abrir(BuildContext context, int indice) {
    final pantallas = <Widget>[
      const GeneroScreen(),
      const UsuarioScreen(),
      const UniversidadesScreen(),
      const ClimaScreen(),
      const PokemonScreen(),
      const NoticiasScreen(),
      const AcercaScreen(),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => pantallas[indice]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CAJA DE',
                      style: TextStyle(
                        color: oscuro,
                        fontSize: 17,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'HERRAMIENTAS',
                      style: TextStyle(
                        color: azul,
                        fontSize: 29,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      height: 175,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF172554), Color(0xFF2563EB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -8,
                            bottom: -18,
                            child: Icon(
                              Icons.build_circle,
                              size: 170,
                              color: Colors.white.withValues(alpha: 0.12),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home_repair_service,
                                  color: Colors.white,
                                  size: 42,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Tus herramientas digitales',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Todo lo que necesitas, en un solo lugar.',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Explora las herramientas',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: oscuro,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Selecciona la función que deseas utilizar.',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = herramientas[index];
                  final color = item['color'] as Color;

                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => abrir(context, index),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: color.withValues(alpha: 0.15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.035),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              item['icono'] as IconData,
                              color: color,
                              size: 27,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            item['titulo'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: oscuro,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item['detalle'] as String,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 11,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: herramientas.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 13,
                  mainAxisExtent: 175,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// COMPONENTES COMPARTIDOS

class PantallaBase extends StatelessWidget {
  final String titulo;
  final Widget child;

  const PantallaBase({super.key, required this.titulo, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}

Widget botonPrincipal(String texto, VoidCallback? accion) {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: FilledButton(
      onPressed: accion,
      style: FilledButton.styleFrom(
        backgroundColor: azul,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(texto),
    ),
  );
}

Widget tarjeta(Widget child) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: child,
  );
}

String textoBonito(String texto) {
  if (texto.isEmpty) return texto;
  return texto[0].toUpperCase() + texto.substring(1);
}

Future<void> abrirUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null || !uri.hasScheme) return;

  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    // El dispositivo puede no tener una aplicación compatible.
  }
}

// 1. PREDECIR GÉNERO

class GeneroScreen extends StatefulWidget {
  const GeneroScreen({super.key});

  @override
  State<GeneroScreen> createState() => _GeneroScreenState();
}

class _GeneroScreenState extends State<GeneroScreen> {
  final nombreController = TextEditingController();
  bool cargando = false;
  String? nombre;
  String? genero;
  double? probabilidad;
  String? error;

  Future<void> consultar() async {
    final entrada = nombreController.text.trim();

    if (entrada.isEmpty) {
      setState(() => error = 'Escribe un nombre.');
      return;
    }

    setState(() {
      cargando = true;
      error = null;
    });

    try {
      final uri = Uri.https('api.genderize.io', '/', {'name': entrada});

      final respuesta = await http.get(uri);

      if (respuesta.statusCode != 200) {
        throw Exception('No se pudo consultar el servicio.');
      }

      final data = jsonDecode(respuesta.body);

      if (data['gender'] == null) {
        throw Exception('No se pudo predecir el género de ese nombre.');
      }

      setState(() {
        nombre = data['name']?.toString() ?? entrada;
        genero = data['gender']?.toString();
        probabilidad = (data['probability'] as num?)?.toDouble();
      });
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => cargando = false);
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final masculino = genero == 'male';
    final color = genero == null
        ? azul
        : masculino
        ? const Color(0xFF2563EB)
        : const Color(0xFFEC4899);

    return PantallaBase(
      titulo: 'Predecir género',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tarjeta(
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.wc, size: 42, color: azul),
                SizedBox(height: 12),
                Text(
                  '¿Qué género predice el nombre?',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: oscuro,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Introduce un nombre para consultar Genderize.',
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nombreController,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              prefixIcon: Icon(Icons.person_outline),
            ),
            onSubmitted: (_) => consultar(),
          ),
          const SizedBox(height: 14),
          botonPrincipal(
            cargando ? 'Consultando...' : 'Predecir',
            cargando ? null : consultar,
          ),
          if (error != null) ...[
            const SizedBox(height: 14),
            Text(error!, style: const TextStyle(color: Colors.red)),
          ],
          if (genero != null) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: color.withValues(alpha: 0.35)),
              ),
              child: Column(
                children: [
                  Icon(
                    masculino ? Icons.male : Icons.female,
                    size: 85,
                    color: color,
                  ),
                  Text(
                    textoBonito(nombre ?? ''),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    masculino ? 'Masculino' : 'Femenino',
                    style: TextStyle(
                      fontSize: 20,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (probabilidad != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      'Probabilidad estimada: '
                      '${(probabilidad! * 100).toStringAsFixed(0)}%',
                    ),
                  ],
                  const SizedBox(height: 8),
                  const Text(
                    'Es una predicción estadística, no una confirmación '
                    'de la identidad de una persona.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// 2. USUARIO ALEATORIO

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  Map<String, dynamic>? usuario;
  bool cargando = false;
  String? error;

  Future<void> cargarUsuario() async {
    setState(() {
      cargando = true;
      error = null;
    });

    try {
      final respuesta = await http.get(
        Uri.https('randomuser.me', '/api/', {'results': '1'}),
      );

      if (respuesta.statusCode != 200) {
        throw Exception('No se pudo obtener el usuario.');
      }

      final data = jsonDecode(respuesta.body);
      final resultados = data['results'] as List;

      setState(() => usuario = resultados.first as Map<String, dynamic>);
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => cargando = false);
    }
  }

  @override
  void initState() {
    super.initState();
    cargarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    final nombreData = usuario?['name'];
    final fechaData = usuario?['dob'];

    return PantallaBase(
      titulo: 'Usuario aleatorio',
      child: Column(
        children: [
          if (cargando) const CircularProgressIndicator(),
          if (error != null) Text(error!),
          if (usuario != null) ...[
            tarjeta(
              Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      usuario!['picture']['large'].toString(),
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, size: 100, color: azul),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '${textoBonito(nombreData['first'].toString())} '
                    '${textoBonito(nombreData['last'].toString())}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: oscuro,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _datoUsuario(
                    Icons.cake_outlined,
                    'Fecha de nacimiento',
                    fechaData['date'].toString().substring(0, 10),
                  ),
                  _datoUsuario(
                    Icons.calendar_month,
                    'Edad',
                    '${fechaData['age']} años',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],
          botonPrincipal(
            cargando ? 'Cargando...' : 'Generar otra persona',
            cargando ? null : cargarUsuario,
          ),
        ],
      ),
    );
  }

  Widget _datoUsuario(IconData icono, String titulo, String valor) {
    return ListTile(
      leading: Icon(icono, color: azul),
      title: Text(titulo, style: const TextStyle(color: Colors.blueGrey)),
      subtitle: Text(
        valor,
        style: const TextStyle(
          color: oscuro,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

// 3. UNIVERSIDADES POR PAÍS

class UniversidadesScreen extends StatefulWidget {
  const UniversidadesScreen({super.key});

  @override
  State<UniversidadesScreen> createState() => _UniversidadesScreenState();
}

class _UniversidadesScreenState extends State<UniversidadesScreen> {
  final paisController = TextEditingController(text: 'Dominican Republic');
  List<dynamic> universidades = [];
  bool cargando = false;
  String? error;

  Future<void> buscar() async {
    final pais = paisController.text.trim();

    if (pais.isEmpty) {
      setState(() => error = 'Escribe el nombre del país en inglés.');
      return;
    }

    setState(() {
      cargando = true;
      error = null;
      universidades = [];
    });

    try {
      final uri = Uri.https('adamix.net', '/proxy.php', {'country': pais});

      final respuesta = await http.get(uri);

      if (respuesta.statusCode != 200) {
        throw Exception('Error consultando universidades.');
      }

      final data = jsonDecode(respuesta.body);

      if (data is List) {
        setState(() => universidades = data);
      } else if (data is Map && data['universities'] is List) {
        setState(() => universidades = data['universities'] as List);
      } else {
        throw Exception('La API devolvió un formato inesperado.');
      }

      if (universidades.isEmpty) {
        setState(() => error = 'No se encontraron universidades.');
      }
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => cargando = false);
    }
  }

  @override
  void dispose() {
    paisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PantallaBase(
      titulo: 'Universidades',
      child: Column(
        children: [
          const Text(
            'Busca instituciones educativas por país. Escribe el nombre '
            'del país en inglés.',
            style: TextStyle(color: Colors.blueGrey),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: paisController,
            decoration: const InputDecoration(
              labelText: 'País en inglés',
              prefixIcon: Icon(Icons.public),
            ),
            onSubmitted: (_) => buscar(),
          ),
          const SizedBox(height: 12),
          botonPrincipal(
            cargando ? 'Buscando...' : 'Buscar universidades',
            cargando ? null : buscar,
          ),
          if (cargando) ...[
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
          if (error != null) ...[
            const SizedBox(height: 15),
            Text(error!, style: const TextStyle(color: Colors.red)),
          ],
          const SizedBox(height: 18),
          ...universidades.map((item) {
            final uni = item as Map<String, dynamic>;
            final nombre = (uni['name'] ?? uni['universidad'] ?? 'Universidad')
                .toString();
            final dominio = (uni['domains'] ?? uni['domain'] ?? 'No disponible')
                .toString();
            final web = (uni['web_pages'] ?? uni['webpage'] ?? uni['url'] ?? '')
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '');

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: tarjeta(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: oscuro,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dominio: $dominio',
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                    if (web.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () => abrirUrl(
                          web.startsWith('http') ? web : 'https://$web',
                        ),
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Visitar página web'),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// 4. CLIMA ACTUAL EN REPÚBLICA DOMINICANA

class ClimaScreen extends StatefulWidget {
  const ClimaScreen({super.key});

  @override
  State<ClimaScreen> createState() => _ClimaScreenState();
}

class _ClimaScreenState extends State<ClimaScreen> {
  Map<String, dynamic>? clima;
  bool cargando = false;
  String? error;

  Future<void> consultarClima() async {
    setState(() {
      cargando = true;
      error = null;
    });

    try {
      // Coordenadas aproximadas de Santo Domingo.
      final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
        'latitude': '18.4861',
        'longitude': '-69.9312',
        'current':
            'temperature_2m,relative_humidity_2m,apparent_temperature,'
            'is_day,precipitation,weather_code,wind_speed_10m',
        'daily': 'temperature_2m_max,temperature_2m_min,weather_code',
        'timezone': 'America/Santo_Domingo',
        'forecast_days': '1',
      });

      final respuesta = await http.get(uri);

      if (respuesta.statusCode != 200) {
        throw Exception('No se pudo consultar el clima.');
      }

      setState(() => clima = jsonDecode(respuesta.body));
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => cargando = false);
    }
  }

  @override
  void initState() {
    super.initState();
    consultarClima();
  }

  String descripcionClima(int codigo) {
    if (codigo == 0) return 'Despejado';
    if ([1, 2, 3].contains(codigo)) return 'Parcialmente nublado';
    if ([45, 48].contains(codigo)) return 'Niebla';
    if ([51, 53, 55, 56, 57].contains(codigo)) return 'Llovizna';
    if ([61, 63, 65, 66, 67, 80, 81, 82].contains(codigo)) return 'Lluvia';
    if ([71, 73, 75, 77, 85, 86].contains(codigo)) return 'Nieve';
    if ([95, 96, 99].contains(codigo)) return 'Tormenta';
    return 'Condición meteorológica variable';
  }

  @override
  Widget build(BuildContext context) {
    final actual = clima?['current'];
    final diario = clima?['daily'];

    return PantallaBase(
      titulo: 'Clima en República Dominicana',
      child: Column(
        children: [
          tarjeta(
            Column(
              children: [
                const Icon(Icons.location_on, color: azul, size: 35),
                const Text(
                  'Santo Domingo, RD',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: oscuro,
                  ),
                ),
                const SizedBox(height: 5),
                const Text('Condiciones meteorológicas actuales'),
                const SizedBox(height: 18),
                if (cargando) const CircularProgressIndicator(),
                if (error != null)
                  Text(error!, style: const TextStyle(color: Colors.red)),
                if (actual != null && diario != null) ...[
                  const Icon(
                    Icons.wb_cloudy,
                    size: 75,
                    color: Color(0xFFF59E0B),
                  ),
                  Text(
                    '${actual['temperature_2m']} °C',
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: azul,
                    ),
                  ),
                  Text(
                    descripcionClima((actual['weather_code'] ?? 0) as int),
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 22),
                  _filaClima(
                    'Máxima de hoy',
                    '${diario['temperature_2m_max'][0]} °C',
                  ),
                  _filaClima(
                    'Mínima de hoy',
                    '${diario['temperature_2m_min'][0]} °C',
                  ),
                  _filaClima(
                    'Sensación térmica',
                    '${actual['apparent_temperature']} °C',
                  ),
                  _filaClima('Humedad', '${actual['relative_humidity_2m']}%'),
                  _filaClima('Viento', '${actual['wind_speed_10m']} km/h'),
                  _filaClima('Precipitación', '${actual['precipitation']} mm'),
                  const SizedBox(height: 12),
                  const Text(
                    'Datos meteorológicos de Open-Meteo.',
                    style: TextStyle(fontSize: 11, color: Colors.blueGrey),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          botonPrincipal(
            cargando ? 'Actualizando...' : 'Actualizar clima',
            cargando ? null : consultarClima,
          ),
        ],
      ),
    );
  }

  Widget _filaClima(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo, style: const TextStyle(color: Colors.blueGrey)),
          Text(
            valor,
            style: const TextStyle(fontWeight: FontWeight.bold, color: oscuro),
          ),
        ],
      ),
    );
  }
}

// 5. POKÉMON

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final nombreController = TextEditingController(text: 'pikachu');
  final reproductor = AudioPlayer();

  Map<String, dynamic>? pokemon;
  bool cargando = false;
  String? error;
  bool reproduciendo = false;

  Future<void> buscarPokemon() async {
    final nombre = nombreController.text.trim().toLowerCase();

    if (nombre.isEmpty) {
      setState(() => error = 'Escribe el nombre de un Pokémon.');
      return;
    }

    setState(() {
      cargando = true;
      error = null;
      pokemon = null;
    });

    try {
      final respuesta = await http.get(
        Uri.https('pokeapi.co', '/api/v2/pokemon/$nombre'),
      );

      if (respuesta.statusCode != 200) {
        throw Exception('No se encontró ese Pokémon.');
      }

      setState(() => pokemon = jsonDecode(respuesta.body));
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => cargando = false);
    }
  }

  Future<void> reproducirSonido() async {
    final url = pokemon?['cries']?['latest']?.toString();

    if (url == null || url.isEmpty) {
      setState(() => error = 'Este Pokémon no tiene sonido disponible.');
      return;
    }

    try {
      await reproductor.stop();
      await reproductor.play(UrlSource(url));
    } catch (_) {
      setState(() => error = 'No se pudo reproducir el sonido.');
    }
  }

  @override
  void initState() {
    super.initState();
    buscarPokemon();
  }

  @override
  void dispose() {
    nombreController.dispose();
    reproductor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habilidades = pokemon?['abilities'] as List? ?? [];
    final sprites = pokemon?['sprites'];
    final imagen =
        sprites?['other']?['official-artwork']?['front_default']?.toString() ??
        sprites?['front_default']?.toString();

    return PantallaBase(
      titulo: 'Pokémon',
      child: Column(
        children: [
          TextField(
            controller: nombreController,
            decoration: const InputDecoration(
              labelText: 'Nombre del Pokémon',
              prefixIcon: Icon(Icons.catching_pokemon),
            ),
            onSubmitted: (_) => buscarPokemon(),
          ),
          const SizedBox(height: 12),
          botonPrincipal(
            cargando ? 'Buscando...' : 'Buscar Pokémon',
            cargando ? null : buscarPokemon,
          ),
          if (cargando) ...[
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
          if (error != null) ...[
            const SizedBox(height: 12),
            Text(error!, style: const TextStyle(color: Colors.red)),
          ],
          if (pokemon != null) ...[
            const SizedBox(height: 20),
            tarjeta(
              Column(
                children: [
                  if (imagen != null)
                    Image.network(
                      imagen,
                      height: 190,
                      width: 190,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.catching_pokemon,
                        size: 120,
                        color: Colors.orange,
                      ),
                    ),
                  Text(
                    '#${pokemon!['id']}  ${textoBonito(pokemon!['name'].toString())}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: oscuro,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _datoPokemon(
                    'Experiencia base',
                    pokemon!['base_experience']?.toString() ?? 'No disponible',
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Habilidades',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: oscuro,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: habilidades.map((item) {
                      final habilidad = item['ability']['name'].toString();
                      return Chip(
                        label: Text(textoBonito(habilidad)),
                        backgroundColor: const Color(0xFFFFF3CD),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  botonPrincipal(
                    reproduciendo ? 'Reproducir sonido' : 'Escuchar sonido',
                    () async {
                      setState(() => reproduciendo = true);
                      await reproducirSonido();
                      if (mounted) {
                        setState(() => reproduciendo = false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _datoPokemon(String titulo, String valor) {
    return ListTile(
      title: Text(titulo),
      trailing: Text(
        valor,
        style: const TextStyle(fontWeight: FontWeight.bold, color: azul),
      ),
    );
  }
}

// 6. NOTICIAS WORDPRESS

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({super.key});

  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}

class _NoticiasScreenState extends State<NoticiasScreen> {
  // Kinsta publica sus artículos en WordPress.
  // Si el endpoint cambia o no permite acceso, se puede configurar otro sitio.
  static const String sitio = 'https://kinsta.com';
  List<dynamic> noticias = [];
  bool cargando = false;
  String? error;

  Future<void> cargarNoticias() async {
    setState(() {
      cargando = true;
      error = null;
    });

    try {
      final uri = Uri.parse('$sitio/wp-json/wp/v2/posts?per_page=3&_embed=1');
      final respuesta = await http.get(uri);

      if (respuesta.statusCode != 200) {
        throw Exception(
          'No se pudieron obtener las noticias de WordPress. '
          'El sitio puede limitar el acceso a su API.',
        );
      }

      final data = jsonDecode(respuesta.body);

      if (data is! List) {
        throw Exception('La API devolvió un formato inesperado.');
      }

      setState(() => noticias = data);
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => cargando = false);
    }
  }

  @override
  void initState() {
    super.initState();
    cargarNoticias();
  }

  String limpiarHtml(String texto) {
    return texto
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&amp;', '&')
        .replaceAll('&#8217;', '’')
        .replaceAll('&#8211;', '–')
        .replaceAll('&#8220;', '“')
        .replaceAll('&#8221;', '”')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    return PantallaBase(
      titulo: 'Noticias WordPress',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tarjeta(
            const Row(
              children: [
                Icon(Icons.language, color: azul, size: 40),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kinsta Blog',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: oscuro,
                        ),
                      ),
                      Text(
                        'Últimas publicaciones',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (cargando) const Center(child: CircularProgressIndicator()),
          if (error != null) ...[
            Text(error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            botonPrincipal('Intentar nuevamente', cargarNoticias),
          ],
          ...noticias.map((item) {
            final noticia = item as Map<String, dynamic>;
            final titulo = limpiarHtml(
              noticia['title']?['rendered']?.toString() ?? 'Sin título',
            );
            final resumen = limpiarHtml(
              noticia['excerpt']?['rendered']?.toString() ?? '',
            );
            final enlace = noticia['link']?.toString() ?? sitio;

            String? imagen;
            final media = noticia['_embedded']?['wp:featuredmedia'];
            if (media is List && media.isNotEmpty) {
              imagen = media.first['source_url']?.toString();
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: tarjeta(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (imagen != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imagen,
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: oscuro,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(resumen, maxLines: 4, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => abrirUrl(enlace),
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Visitar noticia'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// 7. ACERCA DE

class AcercaScreen extends StatelessWidget {
  const AcercaScreen({super.key});

  static const String correo = 'ashleyperez.19026@gmail.com';
  static const String telefono = '8492209357';
  static const String linkedin =
      'https://www.linkedin.com/in/ashley-p%C3%A9rez-57442a24a/?isSelfProfile=true';
  static const String github = 'https://github.com/Ashley-PV';

  Future<void> abrirContacto(BuildContext context, String url) async {
    try {
      await abrirUrl(url);
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Widget contacto({
    required IconData icono,
    required String titulo,
    required String valor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: fondo,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: azul.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icono, color: azul, size: 23),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        valor,
                        style: const TextStyle(
                          color: oscuro,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.open_in_new, color: azul, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PantallaBase(
      titulo: 'Acerca de',
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFDBEAFE), Color(0xFFEDE9FE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: oscuro.withValues(alpha: 0.12),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/ashley.png',
                      width: 116,
                      height: 116,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const CircleAvatar(
                          radius: 58,
                          backgroundColor: Color(0xFFDBEAFE),
                          child: Icon(Icons.person, size: 65, color: azul),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Ashley Elizabeth Pérez Vinicio',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: oscuro,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Desarrollo de Software',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: azul,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Apasionada por la tecnología, el aprendizaje y la creación de soluciones digitales.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: oscuro, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          tarjeta(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Información de contacto',
                  style: TextStyle(
                    color: oscuro,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 17),
                contacto(
                  icono: Icons.email_outlined,
                  titulo: 'Correo electrónico',
                  valor: correo,
                  onTap: () => abrirContacto(context, 'mailto:$correo'),
                ),
                contacto(
                  icono: Icons.phone_outlined,
                  titulo: 'Teléfono',
                  valor: telefono,
                  onTap: () => abrirContacto(context, 'tel:$telefono'),
                ),
                contacto(
                  icono: Icons.work_outline,
                  titulo: 'LinkedIn',
                  valor: 'Ver perfil profesional',
                  onTap: () => abrirContacto(context, linkedin),
                ),
                contacto(
                  icono: Icons.code,
                  titulo: 'GitHub',
                  valor: 'Ver proyectos',
                  onTap: () => abrirContacto(context, github),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Caja de Herramientas · 2026',
            style: TextStyle(color: Colors.black45, fontSize: 12),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
