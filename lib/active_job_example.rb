require "active_job_example/version"
require "active_job_example/ip_fetcher"
require "active_job_example/worker"
# Usage:
#
# ActiveJobExample.get_ip_now
# ActiveJobExample.get_ip_now!
# ActiveJobExample.get_ip_later
# ActiveJobExample.get_ip_later!
module ActiveJobExample
  def get_ip(id)
    ip_fetcher = ActiveJobExample::IpFetcher.new(id)
    ip_fetcher.get_ip_now
  end
  module_function :get_ip
  def get_ip_later(id)
    ip_fetcher = ActiveJobExample::IpFetcher.new(id)
    ActiveJobExample::Worker.perform_later(ip_fetcher)
  end
  module_function :get_ip_later
end
if defined?(ActiveSupport)
  # :nocov:
  require "active_support/lazy_load_hooks"
  # Add #get_ip and #get_ip_later to controllers
  ActiveSupport.on_load(:action_controller) do
    include ActiveJobExample
  end
  # :nocov:
end
