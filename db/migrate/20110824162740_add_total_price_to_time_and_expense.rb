class AddTotalPriceToTimeAndExpense < ActiveRecord::Migration
  def change
    add_column :time_entries, :total_amount, :decimal, :null => false, :default => 0, :precision => 8, :scale => 2
    add_column :expense_entries, :total_amount, :decimal, :null => false, :default => 0, :precision => 8, :scale => 2
    
    TimeEntry.all.each do |time_entry|
      time_entry.calculate_total
      time_entry.save! if time_entry.changed?
    end
    
    ExpenseEntry.all.each do |expense_entry|
      expense_entry.calculate_total
      expense_entry.save! if expense_entry.changed?
    end
    
  end
end
