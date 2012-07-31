require 'spec_helper'

describe "time_entries/show.html.erb" do
  before(:each) do
    @time_entry = assign(:time_entry, stub_model(TimeEntry,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tstart/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tend/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Notes/)
  end
end
