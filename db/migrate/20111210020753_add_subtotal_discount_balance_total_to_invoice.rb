class AddSubtotalDiscountBalanceTotalToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :subtotal, :decimal, :null => false, :default => 0, :precision => 8, :scale => 2
    add_column :invoices, :discount, :decimal, :null => false, :default => 0, :precision => 8, :scale => 2
    add_column :invoices, :total, :decimal, :null => false, :default => 0, :precision => 8, :scale => 2
    add_column :invoices, :paid, :decimal, :null => false, :default => 0, :precision => 8, :scale => 2    
    add_column :invoices, :balance, :decimal, :null => false, :default => 0, :precision => 8, :scale => 2
    
    add_index :invoices, :balance
    
    add_column :payments, :allocated, :decimal, :null => false, :default => 0, :precision => 8, :scale => 2
    
    Invoice.all.each do |invoice|
      invoice.recalc_totals_from_db!
    end
  end
end
