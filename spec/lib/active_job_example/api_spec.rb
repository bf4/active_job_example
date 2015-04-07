require "active_job_example/api"

RSpec.describe ActiveJobExample::Api, type: :web do

  it "gets my ip" do
    stub_request(:get, "http://ifconfig.me/host").
       to_return(:status => 200, :body => "", :headers => {})
    ActiveJobExample::Api.get_ip
  end

  it "gets my ip!" do
    stub_request(:get, "http://ifconfig.me/host").
       to_return(:status => 500, :body => "", :headers => {})
    ActiveJobExample::Api.get_ip!
  end

end
