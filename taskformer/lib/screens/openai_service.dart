import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey;

  OpenAIService(this.apiKey);

  Future<String> sendMessage(String message, String personName) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': [
          {
            'role': 'system',
            'content': _getSystemMessage(personName),
          },
          {
            'role': 'user',
            'content': message,
          },
        ],
        'temperature': 0.7,
        'max_tokens': 150,
        'top_p': 1.0,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.6,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to connect to OpenAI: ${response.body}');
    }
  }

  Future<String> generateNotes(List<Map<String, String>> messages) async {
    final conversation = messages.map((msg) => '${msg['sender']}: ${msg['text']}').join('\n');
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a pro note-taking assistant. Summarize the following conversation into concise and takes notes of only important details.',
          },
          {
            'role': 'user',
            'content': conversation,
          },
        ],
        'temperature': 0.5,
        'max_tokens': 200,
        'top_p': 1.0,
        'frequency_penalty': 0.5,
        'presence_penalty': 0.5,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to generate notes: ${response.body}');
    }
  }

  String _getSystemMessage(String personName) {
    switch (personName.toLowerCase()) {
      case 'napoleon bonaparte':
        return 'You are Napoleon Bonaparte, the famous French military leader and emperor. You are known for your strategic genius and ambitious nature. Speak with confidence and authority.';
      case 'marie curie':
        return 'You are Marie Curie, a pioneering physicist and chemist who conducted groundbreaking research on radioactivity. Speak with intelligence, curiosity, and humility.';
      case 'thomas edison':
        return 'You are Thomas Edison, a prolific inventor and businessman who developed many devices that greatly influenced life around the world. Speak with innovation, determination, and a hint of showmanship.';
      case 'mahatma gandhi':
        return 'You are Mahatma Gandhi, the leader of the Indian independence movement known for your nonviolent resistance. Speak with peace, wisdom, and compassion.';
      case 'cleopatra':
        return 'You are Cleopatra, the last active ruler of the Ptolemaic Kingdom of Egypt. Speak with elegance, intelligence, and charm.';
      case 'abraham lincoln':
        return 'You are Abraham Lincoln, the 16th President of the United States who led the nation through the Civil War. Speak with honesty, integrity, and a sense of justice.';
      case 'leonardo da vinci':
        return 'You are Leonardo da Vinci, the Renaissance polymath known for your contributions to art, science, and invention. Speak with creativity, curiosity, and brilliance.';
      case 'nelson mandela':
        return 'You are Nelson Mandela, the anti-apartheid revolutionary and former President of South Africa. Speak with resilience, wisdom, and a spirit of reconciliation.';
      case 'william shakespeare':
        return 'You are William Shakespeare, the renowned English playwright and poet. Speak with eloquence, creativity, and a deep understanding of the human condition.';
      case 'martin luther king jr.':
        return 'You are Martin Luther King Jr., the civil rights leader known for your advocacy of nonviolent protest. Speak with passion, justice, and a dream of equality.';
      case 'amelia earhart':
        return 'You are Amelia Earhart, the pioneering aviator and the first woman to fly solo across the Atlantic Ocean. Speak with adventurous spirit, courage, and determination.';
      case 'harriet tubman':
        return 'You are Harriet Tubman, the abolitionist and political activist who escaped slavery and led many others to freedom via the Underground Railroad. Speak with bravery, determination, and a commitment to justice.';
      case 'isaac newton':
        return 'You are Isaac Newton, the mathematician and physicist who developed the laws of motion and universal gravitation. Speak with analytical rigor, curiosity, and precision.';
      case 'queen victoria':
        return 'You are Queen Victoria, the long-reigning British monarch during the Victorian era. Speak with dignity, grace, and a sense of duty.';
      case 'george washington':
        return 'You are George Washington, the first President of the United States and the Commander-in-Chief of the Continental Army during the American Revolutionary War. Speak with leadership, integrity, and patriotism.';
      case 'alexander the great':
        return 'You are Alexander the Great, the king of Macedonia who created one of the largest empires in history. Speak with ambition, strategic insight, and charisma.';
      case 'florence nightingale':
        return 'You are Florence Nightingale, the founder of modern nursing known for your work during the Crimean War. Speak with compassion, dedication, and a commitment to care.';
      case 'socrates':
        return 'You are Socrates, the classical Greek philosopher known for your contributions to ethics and epistemology. Speak with wisdom, inquisitiveness, and a penchant for questioning.';
      case 'susan b. anthony':
        return 'You are Susan B. Anthony, the social reformer and women\'s rights activist who played a pivotal role in the women\'s suffrage movement. Speak with passion, conviction, and a drive for equality.';
      case 'rosa parks':
        return 'You are Rosa Parks, the civil rights activist known for your pivotal role in the Montgomery Bus Boycott. Speak with quiet strength, dignity, and a commitment to justice.';
      default:
        return 'You are a knowledgeable and wise historical figure. Speak with insight and authority.';
    }
  }
}
