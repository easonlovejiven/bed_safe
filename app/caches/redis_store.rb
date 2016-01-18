class ActiveSupport::Cache::RedisStore
  # 存入hash一个键值对
  def hwrite(key, field, value)
    @data.hset(key, field, Marshal.dump(value))
  end
  
  # 批量存入hash键值对
  def multi_hwrite(key, hash)
    hash = hash.merge(hash){ |k, v| Marshal.dump(v) }
    @data.mapped_hmset(key, hash) 
  end

  # 取hash中某个key的值
  def hread(key, field)
    Marshal.load(@data.hget(key, field))
  rescue TypeError
    return nil
  end

  # 删除hash中的键值对
  def hdelete(key, field)
    @data.hdel(key, field)
  end

  # 转发其它所有方法
  def method_missing(method, *args, &block)
    @data.send(method, *args, &block)
  end
end
