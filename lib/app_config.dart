abstract class AppConfig {
  static String baseUrl;

  static setUpEnv(Environment env) {
    switch (env) {
      case Environment.dev:
        {
          baseUrl = '';
          break;
        }
      case Environment.prod:
        {
          baseUrl = '';
          break;
        }
      case Environment.stage:
        {
          baseUrl = '';
          break;
        }
    }
  }
}

enum Environment { dev, stage, prod }