class AddColsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :assigned_to, :integer
    add_column :orders, :comment, :string
    add_column :orders, :estimated_time, :float
  end
end
