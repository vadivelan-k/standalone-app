require "spec_helper"

describe FirmsController do
  describe "routing" do

    it "routes to #index" do
      get("/firms").should route_to("firms#index")
    end

    it "routes to #new" do
      get("/firms/new").should route_to("firms#new")
    end

    it "routes to #show" do
      get("/firms/1").should route_to("firms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/firms/1/edit").should route_to("firms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/firms").should route_to("firms#create")
    end

    it "routes to #update" do
      put("/firms/1").should route_to("firms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/firms/1").should route_to("firms#destroy", :id => "1")
    end

  end
end
