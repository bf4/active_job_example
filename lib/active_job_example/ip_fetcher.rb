require "active_job_example/api"
require "active_job_example/worker"
module ActiveJobExample
  class IpFetcher
    require "global_id/identification"
    include GlobalID::Identification
    require "active_model/serialization"
    include ActiveModel::Serialization

    # HACK: since this global id isn't really global
    # just for demo'ing the interface
    def self.find(id)
      new(id)
    end

    attr_reader :id
    def initialize(id)
      @id = id
    end

    def get_ip_now
      ActiveJobExample::Api.get_ip
    end

    def get_ip_now!
      ActiveJobExample::Api.get_ip!
    end

    # ==== Options
    # * <tt>:wait</tt> - Enqueues the job with the specified delay
    # * <tt>:wait_until</tt> - Enqueues the job at the time specified
    # * <tt>:queue</tt> - Enqueues the job on the specified queue
    def get_ip_later(options = {})
      if options.empty?
        ActiveJobExample::Worker
      else
        ActiveJobExample::Worker.set(options)
      end.perform_later(self)
    end
  end
end
