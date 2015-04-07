RSpec.describe ActiveJobExample::Worker, :worker do

  it "enqueues a job" do
    id = 2
    ip_fetcher = ActiveJobExample::IpFetcher.new(id)
    assert_enqueued_jobs 1 do
      ActiveJobExample::Worker.perform_later(ip_fetcher)
    end
  end

  it "ActiveJobExample.get_ip_later" do
    id = 1
    assert_enqueued_jobs 1 do
      ActiveJobExample.get_ip_later(id)
    end
  end

end
