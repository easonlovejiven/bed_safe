$redis_conf = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env].with_indifferent_access
Redis.current = Redis.new(host: $redis_conf['host'], port: $redis_conf['port'], timeout: 300, driver: :hiredis)

# Redis 全局变量
$redis = Redis.current

# 全局缓存
$cache = Cache.new

Resque.redis = $redis