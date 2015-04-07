require "active_job_example/api"
require "active_job"
module ActiveJobExample
  class Worker < ActiveJob::Base
    queue_as :ip_fetcher

    def serialize
      super.merge("attempt_number" => (@attempt_number || 0) + 1)
    end

    def deserialize(job_data)
      super
      @attempt_number = job_data["attempt_number"]
    end


    # @see https://github.com/mperham/sidekiq/wiki/Active-Job
    # rescue_from ActiveRecord::RecordNotFound, with: -> {}

    # @see IpFetcher#get_ip_later(options)
    rescue_from(ActiveJobExample::Api::Error) do |exception|
      raise exception if @attempt_number > 5
      retry_job(wait: 10, queue: :low_priority)
    end

    def perform(ip_fetcher)
      ip_fetcher.get_ip_now!
    end
  end
end
# Available callbacks
#
# before_enqueue
# around_enqueue
# after_enqueue
# before_perform
# around_perform
# after_perform
#
# load hooks
# ActiveSupport.run_load_hooks(:active_job, self)
