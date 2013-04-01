include_recipe "redis::install"

if  File.exists?("/etc/init.d/redis-server")
  service "redis-server" do
    service_name "redis-server"
    action :stop
  end
end

redis_instance "server" do
  conf_dir      node.redis.conf_dir
  init_style    node.redis.init_style

  # user service & group
  user          node.redis.user
  group         node.redis.group

  node.redis.config.each do |attribute, value|
    send(attribute, value)
  end
end
