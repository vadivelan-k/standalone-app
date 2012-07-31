require 'spec_helper'

describe "matters/new.html.erb" do
  before(:each) do
    assign(:matter, stub_model(Matter,
      :client_id => 1,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new matter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => matters_path, :method => "post" do
      assert_select "input#matter_client_id", :name => "matter[client_id]"
      assert_select "input#matter_name", :name => "matter[name]"
    end
  end
end
