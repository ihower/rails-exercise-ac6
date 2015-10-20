require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /events" do
    it "should events list" do
      e1 = Event.create!( :name => "foo", :friendly_id => "foo")
      e2 = Event.create!( :name => "bar", :friendly_id => "bar")

      e1.reload
      e2.reload

      get "/api/v1/events"

      expected_response_data = { "metadata" => { "total" =>2 },
               "data"=>[
                 { "id"=> e1.id, "name"=> e1.name, "created_at"=> e1.created_at },
                 { "id"=> e2.id, "name"=> e2.name, "created_at"=> e2.created_at }
               ]
              }

      expect(response).to have_http_status(200)
      expect( response.body ).to eq( expected_response_data.to_json )
    end
  end

  describe "POST /events" do
    it "should create event failed" do
      post "/api/v1/events"

      expect(response).to have_http_status(400)
    end

    it "should create event successfully" do
      post "/api/v1/events", { :name => "foobar", :friendly_id => "foobar" }

      event = Event.last
      data = {
        "message" => "OK",
        "id" => event.id
      }

      expect( JSON.parse(response.body) ).to eq( data )
      expect(response).to have_http_status(200)

      expect(event.name).to eq("foobar")
    end
  end

end
