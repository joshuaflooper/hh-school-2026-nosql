package ratelimiter;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.time.Instant;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class RateLimiter {

  private final Jedis redis;
  private final String label;
  private final long maxRequestCount;
  private final long timeWindowSeconds;
  private final long timeWindowMilli;

  public RateLimiter(Jedis redis, String label, long maxRequestCount, long timeWindowSeconds) {
    this.redis = redis;
    this.label = label;
    this.maxRequestCount = maxRequestCount;
    this.timeWindowSeconds = timeWindowSeconds;
    timeWindowMilli = timeWindowSeconds * 1000; // Чтобы не умножать каждый раз
  }

// Скользящий журнал из статьи?

  public boolean pass() {
    if (maxRequestCount == 0) {
      return false;
    }

    String key = "request:%s".formatted(label);
    String value;
    long now = Instant.now().toEpochMilli();

    value = redis.lindex(key, maxRequestCount - 1);

    if (value != null
        && now - Long.parseLong(value) < timeWindowMilli) {
      return false;
    }

    redis.lpush(key, String.valueOf(now));
    return true;
  }

// Ниже моя первая реализация.
// Фактически это фиксированное окно из статьи, поэтому тест для скользящего окна она не проходит.

//  public boolean pass() {
//    if (maxRequestCount == 0) {
//      return false;
//    }
//
//    String key = "request:%s".formatted(label);
//    String value;
//
//    value = redis.get(key);
//
//    if (value != null
//        && Long.parseLong(value) >= maxRequestCount) {
//      return false;
//    }
//
//    redis.incr(key);
//    redis.expire(key, timeWindowSeconds, ExpiryOption.NX);
//    return true;
//  }

  public static void main(String[] args) {
    JedisPool pool = new JedisPool("localhost", 6379);

    try (Jedis redis = pool.getResource()) {
      RateLimiter rateLimiter = new RateLimiter(redis, "pr_rate", 1, 1);

      BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
      long prev = Instant.now().toEpochMilli();
      long now;

      while (true) {
        try {
          String s = br.readLine();
          if (s == null || s.equals("q")) {
            return;
          }
          boolean passed = rateLimiter.pass();

          now = Instant.now().toEpochMilli();
          if (passed) {
            System.out.printf("%d ms: %s", now - prev, "passed");
            prev = now;
          } else {
            System.out.printf("%d ms: %s", now - prev, "limited");
          }
        } catch (IOException e) {
          e.printStackTrace();
        }
      }

    }
  }
}
