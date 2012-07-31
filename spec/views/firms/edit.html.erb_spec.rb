require 'spec_helper'

describe "firms/edit.html.erb" do
  before(:each) do
    @firm = assign(:firm, stub_model(Firm,
      :name => "MyString"
    ))
  end

  it "renders the edit firm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => firms_path(@firm), :method => "post" do
      assert_select "input#firm_name", :name => "firm[name]"
    end
  end
end
