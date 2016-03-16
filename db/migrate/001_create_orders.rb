class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer  :project_id
      t.integer  :project_duration_time
      t.text     :persons
      t.text     :details
      t.text     :devices
      t.text     :workflow
      t.text     :additional_information
      t.integer  :status
      t.integer  :created_by
      t.timestamps null: false
    end
  end
end
