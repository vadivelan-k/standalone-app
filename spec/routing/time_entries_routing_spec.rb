require "spec_helper"

describe TimeEntriesController do
  describe "routing" do

    it "routes to #index" do
      get("/time_entries").should route_to("time_entries#index")
    end

    it "routes to #new" do
      get("/time_entries/new").should route_to("time_entries#new")
    end

    it "routes to #show" do
      get("/time_entries/1").should route_to("time_entries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/time_entries/1/edit").should route_to("time_entries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/time_entries").should route_to("time_entries#create")
    end

    it "routes to #update" do
      put("/time_entries/1").should route_to("time_entries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/time_entries/1").should route_to("time_entries#destroy", :id => "1")
    end

  end
end
