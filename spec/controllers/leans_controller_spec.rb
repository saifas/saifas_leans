require 'json'

require 'spec_helper'
require 'test_helpers/leans_controller_spec_helper'

RSpec.configure do |config|
  config.include LeansControllerSpecHelper
end

describe LeansController do

  context "routes" do

    it "'/' to {:controller => leans, :action => show, :id => '1'}" do
      expect(:get => '/').to route_to({:controller => 'leans', 
                                                :action => 'show', :id => 1})
    end

    it "'/leans/:id' to {:controller => leans, :action => show, :id => id}" do
      expect(:get => '/leans/:id').to route_to({:controller => 'leans', 
                                                :action => 'show', :id => ":id"})
    end

  end

  context "when 'show' via :get" do

    let(:lean) { FactoryGirl.create :lean }

    it 'responds with 200' do
      expect(response).to be_success
    end

    it "responds with 404 if lean.nil?" do
      get 'show', :id => 0
      expect(response).to be_not_found
    end

    it "returns valid json" do
      get 'show', :id => lean.id, :format => :json
      expect(response.body).to be_eql(results(lean.id).to_json)
    end

    it "makes request_log" do
      get 'show', :id => lean.id, :format => :json
      expect(RequestLogs.last).to be_same(logs)
    end

  end

end
