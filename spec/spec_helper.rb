require "bundler/setup"

require "pathname"
module AppRoot
  ROOT = Pathname File.expand_path("../..", __FILE__)
  def root
    ROOT
  end
  module_function :root
end
def app_root
  AppRoot.root
end

lib_dir = app_root.join("lib").to_s
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require "dotenv"
env_files = %w[.env]
Dotenv.load(*env_files)

require "simplecov"

require "active_job_example"
require "support/active_job"
#
# ActiveJob::Base.queue_adapter = :sidekiq
# ActiveSupport.run_load_hooks(:active_job, self)
# @adapter  = ENV['AJ_ADAPTER'] || 'inline'
# ActiveJob::Base.queue_adapter = @adapter

require "global_id"
GlobalID.app = "active-job-example"

require "webmock/rspec"
WebMock.disable_net_connect!
