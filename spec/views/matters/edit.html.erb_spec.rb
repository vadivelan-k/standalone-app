require 'spec_helper'

describe "matters/edit.html.erb" do
  before(:each) do
    @matter = assign(:matter, stub_model(Matter,
      :client_id => 1,
      :name => "MyString"
    ))
  end

  it "renders the edit matter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => matters_path(@matter), :method => "post" do
      assert_select "input#matter_client_id", :name => "matter[client_id]"
      assert_select "input#matter_name", :name => "matter[name]"
    end
  end
end
