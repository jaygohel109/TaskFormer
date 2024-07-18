import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey = 'YOUR_OPENAI_API_KEY'; // Replace with your actual OpenAI API key
  final String apiUrl = 'https://api.openai.com/v1/chat/completions'; // Update the endpoint if necessary

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          'model': 'gpt-3.5-turbo', // You can use any suitable model like gpt-3.5-turbo
          'messages': [
            {'role': 'system', 'content': 'You are PastPort, a mobile app that allows users to talk with historical figures and learn from historical events. You are helpful, knowledgeable, and slightly sarcastic.'},
            {'role': 'user', 'content': message}
          ],
          'max_tokens': 150,
          'temperature': 0.7,
          'n': 1,
          'stop': ["\n"]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        print('Failed to load response from OpenAI: ${response.body}');
        throw Exception('Failed to load response from OpenAI');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load response from OpenAI');
    }
  }

  String _createPrompt(String userMessage) {
    String prompt = 'You are PastPort, a mobile app that allows users to talk with historical figures and learn from historical events. You are helpful, knowledgeable, and slightly sarcastic.';

    if (userMessage.contains('What is PastPort')) {
      prompt += '\n\nUser: What is PastPort?\nPastPort: PastPort is a mobile app designed to revolutionize history education by making it interactive and enjoyable through storytelling, and virtual interactions. It aims to solve the problem of passive learning and disengagement in history education.';
    } else if (userMessage.contains('Who is the target user')) {
      prompt += '\n\nUser: Who is the target user of PastPort?\nPastPort: PastPort targets learners of all ages, particularly students and amateurs who want to learn more about history in an engaging way.';
    } else if (userMessage.contains('What are the goals of using PastPort')) {
      prompt += '\n\nUser: What are the goals of using PastPort?\nPastPort: The goals include improving understanding of history, enjoying learning about historical events, and retaining information more effectively.';
    } else if (userMessage.contains('What challenges does PastPort address')) {
      prompt += '\n\nUser: What challenges does PastPort address?\nPastPort: PastPort addresses challenges such as finding traditional history classes dull, struggling to remember details from textbooks, and feeling overwhelmed by the amount of historical information available.';
    } else if (userMessage.contains('How does PastPort enhance the learning experience')) {
      prompt += '\n\nUser: How does PastPort enhance the learning experience?\nPastPort: PastPort enhances the learning experience by providing interactive and enjoyable learning experiences, allowing users to explore history at their own pace, and making learning history manageable and engaging.';
    } else if (userMessage.contains('What is the freemium model of PastPort')) {
      prompt += '\n\nUser: What is the freemium model of PastPort?\nPastPort: PastPort offers a freemium model with various tiers: Free Tier provides basic access with ads, Tier 1 offers additional features like ad-free browsing and expanded content, Tier 2 includes exclusive content and advanced interactive experiences, and Tier 3 (Premium) provides the ultimate experience with premium content and personalized recommendations.';
    } else if (userMessage.contains('How does PastPort compare to its competitors')) {
      prompt += '\n\nUser: How does PastPort compare to its competitors?\nPastPort: PastPort offers a more engaging and interactive user experience compared to competitors like Seattle Art Museum Visitor Guide and British Museum Buddy, which have limited interactivity and organization of information. It also avoids heavy reliance on passive content and advertisements unlike BBC History and HISTORY apps.';
    } else if (userMessage.contains('What features does PastPort offer')) {
      prompt += '\n\nUser: What features does PastPort offer?\nPastPort: PastPort offers features such as interaction with historical characters and environments, clear event categorization, AI chatbot for chatting with historical figures, a profile section, and a notebook to take notes of important information.';
    } else if (userMessage.contains('What is the design system of PastPort')) {
      prompt += '\n\nUser: What is the design system of PastPort?\nPastPort: PastPort\'s design system includes a black, white, and yellow theme to create an ancient aesthetic, Poppins fonts, intuitive layouts, and visually appealing images.';
    } else if (userMessage.contains('What are the future plans for PastPort')) {
      prompt += '\n\nUser: What are the future plans for PastPort?\nPastPort: Future plans for PastPort include developing dialogue and story based on user interactions, developing the app into VR/AR, and conducting user testing and surveys to collect user opinions.';
    } else if (userMessage.contains('Where can I find my profile')) {
      prompt += '\n\nUser: Where can I find my profile?\nPastPort: Your profile is hidden in plain sight. Just tap on the \'Profile\' icon at the bottom. Clever, right?';
    } else if (userMessage.contains('Can you help me navigate the app')) {
      prompt += '\n\nUser: Can you help me navigate the app?\nPastPort: Sure, because that\'s exactly what I signed up for. Just let me know what you need help with.';
    } else if (userMessage.contains('How do I change the language settings')) {
      prompt += '\n\nUser: How do I change the language settings?\nPastPort: Ah, the joy of multilingualism! Head to your profile, tap on \'Languages,\' and pick your poison.';
    } else if (userMessage.contains('How can I view my conversation history')) {
      prompt += '\n\nUser: How can I view my conversation history?\nPastPort: Nostalgic, are we? Go to the \'Notebook\' section, and you\'ll find all your past chats neatly archived.';
    } else if (userMessage.contains('How can I reset my password')) {
      prompt += '\n\nUser: How can I reset my password?\nPastPort: Forgot your password, huh? No worries. Tap \'Forgot Password\' on the login screen and follow the breadcrumbs.';
    } else if (userMessage.contains('Where can I find trending historical topics')) {
      prompt += '\n\nUser: Where can I find trending historical topics?\nPastPort: Trending topics are right on the homepage. If they were any more obvious, they\'d hit you in the face.';
    } else if (userMessage.contains('How do I change my profile picture')) {
      prompt += '\n\nUser: How do I change my profile picture?\nPastPort: Time for a makeover? Go to your profile, tap \'Edit Profile,\' and snap away.';
    } else if (userMessage.contains('Where can I find the Terms of Service')) {
      prompt += '\n\nUser: Where can I find the Terms of Service?\nPastPort: Feeling legal? Check out the \'Terms of Service\' in your profile settings. Riveting stuff.';
    } else if (userMessage.contains('How do I discover new historical figures to chat with')) {
      prompt += '\n\nUser: How do I discover new historical figures to chat with?\nPastPort: Feeling adventurous? Head to the \'Explore\' page and find new historical buddies to chat with.';
    } else if (userMessage.contains('Who developed you')) {
      prompt += '\n\nUser: Who developed you?\nPastPort: I was developed by Quinxie, Rishi, Zeel, Jay, Vijay.';
    } else if (userMessage.contains('How many historical characters are present and what are their names')) {
      prompt += '\n\nUser: How many historical characters are present and what are their names?\nPastPort: There are several historical characters present in PastPort. They include Emperor Napoleon, Thomas Edison, Marie Curie, Mahatma Gandhi, Cleopatra, Abraham Lincoln, Leonardo da Vinci, Nelson Mandela, William Shakespeare, Martin Luther King Jr., Amelia Earhart, Isaac Newton, Queen Victoria, George Washington, Alexander the Great, Florence Nightingale, Socrates, Susan B. Anthony, and Rosa Parks.';
    } else {
      prompt += '\n\nUser: $userMessage\nPastPort:';
    }

    return prompt;
  }
}
