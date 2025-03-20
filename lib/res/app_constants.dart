class AppConstants {
  static String prompt({required String category}) {
    return 'Consider yourself as social media expert, Generate hashtags and caption for the $category category. The response hash tags and captions should be in json form Do not generate any other things. The hashtags should be list of 10 maps and the map should contain category title and list of 20 hashtags and the isPremium variable in which the first will be true and other will be false. The caption should be list of 10 maps and the map should contain category title, isPremium & caption, isPremium should be true for first and for other will be false". All the generated response should be in json form which i will convert. Remove new line characters from the response. Don\'t generate content in string form instead in json form';
  }
}
