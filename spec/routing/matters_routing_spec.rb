require "spec_helper"

describe MattersController do
  describe "routing" do

    it "routes to #index" do
      get("/matters").should route_to("matters#index")
    end

    it "routes to #new" do
      get("/matters/new").should route_to("matters#new")
    end

    it "routes to #show" do
      get("/matters/1").should route_to("matters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/matters/1/edit").should route_to("matters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/matters").should route_to("matters#create")
    end

    it "routes to #update" do
      put("/matters/1").should route_to("matters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/matters/1").should route_to("matters#destroy", :id => "1")
    end

  end
end
