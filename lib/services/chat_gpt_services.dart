import 'package:google_generative_ai/google_generative_ai.dart';

class ChatGPTServices {
  static const apiKey = "AIzaSyCE9eoQ_yav-dLLCiFIsCrGvDcNXHVoHyM";

  static final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
}
