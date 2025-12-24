import 'package:flutter_jarvis/core/base_view_model/base_view_model.dart';
import 'package:flutter_jarvis/core/enums/view_state.dart';
import 'package:flutter_jarvis/core/logger_customizations/custom_logger.dart';
import 'package:flutter_jarvis/core/services/open_api_service.dart';
import 'package:flutter_jarvis/locator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreenViewModel extends BaseViewModel {
  final CustomLogger log = CustomLogger(className: 'HomeViewModel');
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  final OpenApiService _apiService = locator<OpenApiService>();

  String? _generatedContent;
  bool _isListening = false;
  String _lastWords = '';

  bool get isListening => _isListening;
  String get lastWords => _lastWords;
  String? get generatedContent => _generatedContent;
  SpeechToText get speechToText => _speechToText;

  HomeScreenViewModel() {
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await _speechToText.initialize();
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  Future<void> startListening() async {
    if (!_speechToText.isAvailable) return;
    _isListening = true;
    _lastWords = '';
    notifyListeners();

    await _speechToText.listen(
      onResult: onSpeechResult,
      listenFor: Duration(seconds: 30),
      pauseFor: Duration(seconds: 3),
    );
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    _isListening = false;
    notifyListeners();
  }

  void onSpeechResult(SpeechRecognitionResult result) async {
    _lastWords = result.recognizedWords;
    log.d(_lastWords);
    notifyListeners();

    if (result.finalResult) {
      log.i('Final result detected: $_lastWords');
      await stopListening();

      if (_lastWords.isNotEmpty) {
        await claudApi(_lastWords);
      }
    }
  }

  Future<void> claudApi(String lastWords) async {
    setState(ViewState.busy);

    if (lastWords.isEmpty) {
      log.i('No Speech detected');
      setState(ViewState.idle);
      return;
    }

    try {
      final res = await _apiService.claudChat(lastWords);
      log.i('Claude Response: $res');

      _generatedContent = res;

      // Speak the response if it's not an error
      if (!res.toLowerCase().startsWith('error')) {
        await systemSpeak(res);
      }

      notifyListeners();
      setState(ViewState.idle);
    } catch (e) {
      log.e('Error in openApi: $e');
      _generatedContent = 'Error: ${e.toString()}';
      notifyListeners();
      setState(ViewState.idle);
    }
  }

  @override
  void dispose() {
    _speechToText.stop();
    flutterTts.stop();
    super.dispose();
  }
}
