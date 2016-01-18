require 'redis_store'
class Cache
  attr_reader :cache  #convenience for tracing in console

  # 使用默认配置初始化
  def initialize
    @cache = ActiveSupport::Cache::RedisStore.new(host: $redis_conf['host'], port: $redis_conf['port'])
  end

  # 缓存是否存活
  def alive?
    return @cache.stats.present? rescue false
  end

  # 被缓存对象的类变化引起异常时，视为无缓存
  def read(key)
    @cache.read(key)
  rescue TypeError, ArgumentError
    return nil
  end

  # 转发缓存调用方法
  def method_missing(method, *args, &block)
    @cache.send(method, *args, &block) if alive?
  end
end
