require "active_job_example/ip_fetcher"

RSpec.describe ActiveJobExample::IpFetcher, type: :web do
  let(:id) { srand }
  let(:fetcher) { ActiveJobExample::IpFetcher.new(id) }

  it "#get_ip_now" do
    stub_ip_request
    fetcher.get_ip_now
  end

  it "#get_ip_now!" do
    stub_ip_request
    fetcher.get_ip_now!
  end

  it "#get_ip_later", :worker do
    stub_ip_request
    fetcher.get_ip_later
  end

  it "#get_ip_later", :worker, :with_options do
    # stub_ip_request
    options =  {wait: 10, queue: :banana}
    fetcher.get_ip_later(options)
  end

  context "ActiveJobExample" do
    it "#get_ip" do
      stub_ip_request
      ActiveJobExample.get_ip(id)
    end

    it "#get_ip_later", :worker do
      # stub_ip_request
      ActiveJobExample.get_ip_later(id)
    end

    it "#get_ip_later", :worker, :with_options  do
      # stub_ip_request
      ActiveJobExample.get_ip_later(id)
    end
  end

  def stub_ip_request
    stub_request(:get, "http://ifconfig.me/host").
       to_return(:status => 200, :body => "", :headers => {})
  end
end
