abstract class GOAuthAPI {
  Future<String> refresh(String refreshToken);
}

class GOLoginFinishEvent {
  const GOLoginFinishEvent();
}
