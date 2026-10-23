import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const AlastorApp());
}

class AlastorApp extends StatelessWidget {
  const AlastorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accademia di Eloquio di Alastor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF140B0B),
        primaryColor: const Color(0xFF8B0000),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8B0000),
          secondary: Color(0xFFFFD700),
          surface: Color(0xFF261212),
        ),
        useMaterial3: true,
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    PalestraPage(),
    ConsultoPage(),
    GuidaStylePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF261212),
        elevation: 4,
        title: Row(
          children: const [
            Icon(Icons.radio, color: Color(0xFFFFD700)),
            SizedBox(width: 10),
            Text(
              "ACCADEMIA DI ALASTOR",
              style: TextStyle(
                fontFamily: 'serif',
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD700),
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1A0A0A),
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Palestra",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.record_voice_over),
            label: "Consulto",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Guida Stile",
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. PALESTRA DI ELOQUIO
// -----------------------------------------------------------------------------
class PalestraPage extends StatefulWidget {
  const PalestraPage({super.key});

  @override
  State<PalestraPage> createState() => _PalestraPageState();
}

class _PalestraPageState extends State<PalestraPage> {
  final TextEditingController _responseController = TextEditingController();

  final List<String> _scenari = [
    "Un demone ti spintona brutalmente in un locale affollato e ti versa il drink sui vestiti eleganti.",
    "Un collega sfacciato prova a prendersi tutto il merito per un tuo grande successo commerciale.",
    "Un rivale in affari sostiene che la tua radio d'epoca sia spazzatura e propone una tecnologia 'moderna'.",
    "Qualcuno ti minaccia apertamente per strada gridando che ti farà a pezzi.",
    "Un conoscente ti chiede un favore enorme senza offrirti assolutamente nulla in cambio."
  ];

  String _currentScenario = "";
  String _feedback = "";
  int _score = 0;
  String _alastorVersion = "";
  bool _evaluated = false;

  @override
  void initState() {
    super.initState();
    _nuovaSituazione();
  }

  void _nuovaSituazione() {
    setState(() {
      final random = Random();
      _currentScenario = _scenari[random.nextInt(_scenari.length)];
      _responseController.clear();
      _evaluated = false;
    });
  }

  void _valutaRisposta() {
    final text = _responseController.text.trim();
    if (text.isEmpty) return;

    final textLower = text.toLowerCase();
    int tempScore = 35;

    if (textLower.contains("sorris") || textLower.contains("caro") || textLower.contains("amico")) tempScore += 20;
    if (textLower.contains("radio") || textLower.contains("spettacolo") || textLower.contains("musica")) tempScore += 20;
    if (textLower.contains("piacere") || textLower.contains("gentile")) tempScore += 15;
    if (text.endsWith("!") || text.endsWith("...")) tempScore += 10;

    tempScore = tempScore.clamp(20, 98);

    String fb = "";
    String version = "";

    if (tempScore > 75) {
      fb = "Splendido tentativo, mio caro! Hai catturato bene la verve radiofonica. Basta lucidare un paio di accenti d'epoca!";
      version = "Mio caro amico, la maleducazione è il rifugio degli incapaci! Permettimi di offrirti un sorriso prima di sintonizzarti sulla tua ultima trasmissione!";
    } else if (tempScore > 50) {
      fb = "Accettabile, ma manca di quel pizzico di macabra raffinatezza! Ricorda: mai mostrare vera rabbia, mantieni sempre il sorriso!";
      version = "Hahaha! Che esibizione pittoresca! Ma la prossima volta, mio buon amico, impara a gestire lo spettacolo con più classe.";
    } else {
      fb = "Troppo rozzo e diretto! Un vero gentiluomo del microfono affila la lama della cortesia prima di colpire!";
      version = "Oh, che voce sgradevole! Ricorda, caro mio: non sei mai completamente vestito senza un sorriso!";
    }

    setState(() {
      _score = tempScore;
      _feedback = fb;
      _alastorVersion = version;
      _evaluated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: const Color(0xFF261212),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFFFFD700), width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "SITUAZIONE CASUALE",
                    style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currentScenario,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _responseController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Come risponderebbe Alastor?...",
              filled: true,
              fillColor: const Color(0xFF1F0D0D),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF8B0000)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _valutaRisposta,
                  icon: const Icon(Icons.analytics, color: Colors.black),
                  label: const Text("VALUTA RISPOSTA", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700)),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _nuovaSituazione,
                icon: const Icon(Icons.refresh, color: Color(0xFFFFD700)),
                tooltip: "Nuova Situazione",
              ),
            ],
          ),
          if (_evaluated) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F0D0D),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF8B0000)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SINTONIA RADIO: $_score%",
                    style: const TextStyle(color: Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(_feedback, style: const TextStyle(fontStyle: FontStyle.italic)),
                  const Divider(color: Color(0xFF8B0000), height: 24),
                  const Text("COME L'AVREBBE DETTA ALASTOR:", style: TextStyle(color: Color(0xFFFFD700), fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(_alastorVersion, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white09)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. CONSULTO DI ALASTOR
// -----------------------------------------------------------------------------
class ConsultoPage extends StatefulWidget {
  const ConsultoPage({super.key});

  @override
  State<ConsultoPage> createState() => _ConsultoPageState();
}

class _ConsultoPageState extends State<ConsultoPage> {
  final TextEditingController _inputController = TextEditingController();
  String _alastorResponse = "";
  String _bodyLanguage = "";

  void _generaConsulenza() {
    final input = _inputController.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _alastorResponse = "Hahaha! Ma che situazione deliziosamente patetica, mio caro! Di' pure loro: 'Aprezzo infinitamente il vostro vano tentativo di intrattenermi, ma temo che il mio tempo sia decisamente troppo prezioso per questi piccoli giochi da palcoscenico!'";
      _bodyLanguage = "Postura eretta, inclinazione della testa di 15 gradi verso destra, sorriso a 32 denti immobile e sguardo fisso negli occhi.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "RICEVI CONSIGLI DAL RADIO DEMON",
            style: TextStyle(color: Color(0xFFFFD700), fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text("Incolla o descrivi la frase che ti è stata detta o la situazione attuale:"),
          const SizedBox(height: 12),
          TextField(
            controller: _inputController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Es: Il mio datore di lavoro mi ha chiesto di fare gli straordinari gratis...",
              filled: true,
              fillColor: const Color(0xFF1F0D0D),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _generaConsulenza,
            icon: const Icon(Icons.record_voice_over, color: Colors.white),
            label: const Text("RICHIEDI BATTUTA D'ALASTOR", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B0000)),
          ),
          if (_alastorResponse.isNotEmpty) ...[
            const SizedBox(height: 20),
            Card(
              color: const Color(0xFF261212),
              shape: RoundedRectangleBorder(side: const BorderSide(color: Color(0xFFFFD700)), borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("RISPOSTA CONSIGLIATA:", style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(_alastorResponse, style: const TextStyle(fontSize: 16)),
                    const Divider(color: Color(0xFF8B0000)),
                    const Text("LINGUAGGIO DEL CORPO SUGGERITO:", style: TextStyle(color: Color(0xFFFFD700), fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(_bodyLanguage, style: const TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. GUIDA ALLO STILE DI ALASTOR
// -----------------------------------------------------------------------------
class GuidaStylePage extends StatelessWidget {
  const GuidaStylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        Text(
          "IL DECALOGO DEL RADIO DEMON",
          style: TextStyle(color: Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        ListTile(
          leading: Icon(Icons.sentiment_very_satisfied, color: Color(0xFFFFD700)),
          title: Text("1. Il Sorriso Indossato"),
          subtitle: Text("Non sei mai completamente vestito senza un sorriso. Il sorriso nasconde le intenzione e destabilizza l'interlocutore."),
        ),
        ListTile(
          leading: Icon(Icons.radio, color: Color(0xFFFFD700)),
          title: Text("2. Vocabolario Anni '20"),
          subtitle: Text("Usa termini come 'Mio caro', 'Spettacolo', 'Sintonizzati', 'Accattivante', 'Trattativa'."),
        ),
        ListTile(
          leading: Icon(Icons.shield, color: Color(0xFFFFD700)),
          title: Text("3. Cortesia Minacciosa"),
          subtitle: Text("Mantieni sempre un tono estremamente educato, formale e teatrale, anche quando stai insultando qualcuno."),
        ),
      ],
    );
  }
}
