require 'spec_helper'

describe "time_entries/index.html.erb" do
  before(:each) do
    assign(:time_entries, [
      stub_model(TimeEntry,
        :matter_id => 1,
        :user_id => 1,
        :entry_user_id => 1,
        :tstart => "Tstart",
        :tend => "Tend",
        :duration => 1,
        :rate => 1.5,
        :fixed_fee_amount => 1.5,
        :task_id => 1,
        :notes => "Notes"
      ),
      stub_model(TimeEntry,
        :matter_id => 1,
        :user_id => 1,
        :entry_user_id => 1,
        :tstart => "Tstart",
        :tend => "Tend",
        :duration => 1,
        :rate => 1.5,
        :fixed_fee_amount => 1.5,
        :task_id => 1,
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of time_entries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tstart".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tend".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
