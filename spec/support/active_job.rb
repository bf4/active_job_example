module ActiveJobHelper
  def assert_enqueued_jobs(number, only: nil)
    if block_given?
      original_count = enqueued_jobs_size(only: only)
      yield
      new_count = enqueued_jobs_size(only: only)
      expect(original_count + number).to eq(new_count)
    else
      actual_count = enqueued_jobs_size(only: only)
      expect(number).to eq(actual_count)
    end
  end

  def queue_adapter
    ActiveJob::Base.queue_adapter
  end

  delegate :enqueued_jobs, :enqueued_jobs=,
           :performed_jobs, :performed_jobs=,
           to: :queue_adapter

  private

  def clear_enqueued_jobs
    enqueued_jobs.clear
  end

  def clear_performed_jobs
    performed_jobs.clear
  end

  def enqueued_jobs_size(only: nil)
    if only
      enqueued_jobs.select { |job| job.fetch(:job) == only }.size
    else
      enqueued_jobs.size
    end
  end

  def serialize_args_for_assertion(args)
    serialized_args = args.dup
    if job_args = serialized_args.delete(:args)
      serialized_args[:args] = ActiveJob::Arguments.serialize(job_args)
    end
    serialized_args
  end
end
RSpec.configure do |c|
  when_using_active_job = { worker: ->(v) { !!v } }
  c.include ActiveJobHelper, when_using_active_job
  c.before(:each, when_using_active_job) do
    test_adapter = ActiveJob::QueueAdapters::TestAdapter.new
    ActiveJob::Base.queue_adapter = test_adapter
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
