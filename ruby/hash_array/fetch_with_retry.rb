class UnstableApi
  class TimeoutError < StandardError; end
  class RateLimitError < StandardError; end

  def fetch
    r = rand
    raise TimeoutError if r < 0.3
    raise RateLimitError if r < 0.4
    "OK"
  end
end

MAX_ATTEMPTS = 3
BASE_DELAY   = 1

def fetch_with_retry
  api   = UnstableApi.new
  count = 0

  begin

    puts api.fetch
  rescue UnstableApi::TimeoutError => e
    count += 1

    retry if count < MAX_ATTEMPTS
    raise
  rescue UnstableApi::RateLimitError => e
    count += 1

    delay = BASE_DELAY * (2 ** (count -1))
    sleep(delay / 2 + rand(delay / 2))

    retry if count < MAX_ATTEMPTS
    raise
  end
end

fetch_with_retry
