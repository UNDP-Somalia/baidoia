require "rails_helper"

describe InstallationController, type: :request do
  describe "consul.json" do
    let(:output) do
      {
        "debates" => nil,
        "proposals" => "t",
        "polls" => nil,
        "budgets" => "t",
        "legislation" => nil
      }
    end

    before do
      Setting["process.debates"] = false
      Setting["process.proposals"] = true
      Setting["process.polls"] = false
      Setting["process.budgets"] = true
      Setting["process.legislation"] = false
    end

    specify "with query string inside query params" do
      get "/consul.json"

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body["release"]).not_to be_empty
      expect(response.parsed_body["features"]).to eq(output)
    end
  end
end
