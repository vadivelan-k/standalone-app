require 'spec_helper'

describe "firms/show.html.erb" do
  before(:each) do
    @firm = assign(:firm, stub_model(Firm,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
