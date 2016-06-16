class CreateRecurringEvents < ActiveRecord::Migration
  def change
    create_table :recurring_events do |t|
      t.string   :name,                null: false, limit: 250
      t.datetime :start_date,          null: false
      t.integer  :interval_months,     null: false
      t.integer  :day_of_month,        null: false
      t.integer  :deliver_buffer_days, null: false
      t.timestamps null: false
    end
  end
end
