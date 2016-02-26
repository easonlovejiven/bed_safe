class Student
	 @queue = :food

  def self.perform(name)
    p "your name is #{name}"
  end
end

# 执行异步任务
# Resque.enqueue(Student, "eason")

# resque/redis 异步任务/消息队列之间的关系和思路(拿用户注册之后的操作来细说)

# resque 是 基于redis的一个处理后台任务的插件儿 
# 当用户注册完之后,resque把（确认邮件发送等）这些任务
# 写入redis的一个消息队列（这些任务在排队）(所以在使用Resque时，要启动Redis服务才会生效)，然后resque的worker再队列 
# 中的消息，根据取出的消息构造任务，然后执行(取出和执行都是通过worder来完成的)
# 注： 需要启动一个rake命令来产生worker

# resque-scheduler 这个gem可以设置指定任务延时执行 
# 原理:底层使用rufus-scheduler启动一个定时器，定时器从配置文件中获取所有的任务列表，根据列表中的指定时刻，产生resque任务，插入redis消息队列，然后该任务被resque的worker执行

# rufus-scheduler可以使用plain方式，也可以使用eventmachine方式。plain方式就是启动一个loop轮循，比较简单粗糙，因此为了保证健壮性，建议使用eventmachine。无需特别配置，只需在项目中加入eventmachine的gem，rufus即可自动识别并使用EmScheduler模块。 
# 需启动一个rake命令，来调入scheduler配置文件并定时产生各项任务： 
# rake --trace resque:scheduler RAILS_ENV=production


# 异步和定时任务
# gem 'resque', '~> 1.25.1', require: 'resque/server'
# gem 'resque-scheduler', '3.0.0'
# gem 'resque-dynamic-queues'
# gem 'resque-retry'
# gem 'eventmachine'
# gem 'rufus-scheduler', '2.0.24'