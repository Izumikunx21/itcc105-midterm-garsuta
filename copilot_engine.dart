String copilotResponse(String userIntent, {bool isInternetConnected = true}) {
  userIntent = userIntent.toLowerCase();

  if (!isInternetConnected) {
    return "⚠️ Offline mode: Showing saved data only.";
  }

  // Intent evaluation
  if (userIntent.contains("clearance")) {
    return "✅ You have no pending clearance.";
  } else if (userIntent.contains("schedule")) {
    return "📅 You have 3 classes today starting at 9:00 AM.";
  } else if (userIntent.contains("grades")) {
    return "📊 Your average grade is 1.75.";
  } else {
    return "🤖 Sorry, I didn’t understand. Try schedule, grades, or clearance.";
  }
}
