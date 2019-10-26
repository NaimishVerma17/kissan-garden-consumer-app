abstract class AppConfig {
  static String baseUrl;

  static setUpEnv(Environment env) {
    switch (env) {
      case Environment.dev:
        {
          baseUrl = 'https://api.kissangarden.com';
          break;
        }
      case Environment.prod:
        {
          baseUrl = 'https://api.kissangarden.com';
          break;
        }
      case Environment.stage:
        {
          baseUrl = 'https://api.kissangarden.com';
          break;
        }
    }
  }
}

enum Environment { dev, stage, prod }