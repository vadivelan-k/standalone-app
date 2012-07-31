require 'spec_helper'

describe "time_entries/new.html.erb" do
  before(:each) do
    assign(:time_entry, stub_model(TimeEntry,
      :matter_id => 1,
      :user_id => 1,
      :entry_user_id => 1,
      :tstart => "MyString",
      :tend => "MyString",
      :duration => 1,
      :rate => 1.5,
      :fixed_fee_amount => 1.5,
      :task_id => 1,
      :notes => "MyString"
    ).as_new_record)
  end

  it "renders new time_entry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => time_entries_path, :method => "post" do
      assert_select "input#time_entry_matter_id", :name => "time_entry[matter_id]"
      assert_select "input#time_entry_user_id", :name => "time_entry[user_id]"
      assert_select "input#time_entry_entry_user_id", :name => "time_entry[entry_user_id]"
      assert_select "input#time_entry_tstart", :name => "time_entry[tstart]"
      assert_select "input#time_entry_tend", :name => "time_entry[tend]"
      assert_select "input#time_entry_duration", :name => "time_entry[duration]"
      assert_select "input#time_entry_rate", :name => "time_entry[rate]"
      assert_select "input#time_entry_fixed_fee_amount", :name => "time_entry[fixed_fee_amount]"
      assert_select "input#time_entry_task_id", :name => "time_entry[task_id]"
      assert_select "input#time_entry_notes", :name => "time_entry[notes]"
    end
  end
end
