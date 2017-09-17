$redis = Redis::Namespace.new("ihms_env_app", :redis => Redis.new)

uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:url => ENV['REDISTOGO_URL'])