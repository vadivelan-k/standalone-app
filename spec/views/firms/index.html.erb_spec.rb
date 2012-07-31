require 'spec_helper'

describe "firms/index.html.erb" do
  before(:each) do
    assign(:firms, [
      stub_model(Firm,
        :name => "Name"
      ),
      stub_model(Firm,
        :name => "Name"
      )
    ])
  end

  it "renders a list of firms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
