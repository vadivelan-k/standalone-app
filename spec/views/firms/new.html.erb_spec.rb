require 'spec_helper'

describe "firms/new.html.erb" do
  before(:each) do
    assign(:firm, stub_model(Firm,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new firm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => firms_path, :method => "post" do
      assert_select "input#firm_name", :name => "firm[name]"
    end
  end
end
