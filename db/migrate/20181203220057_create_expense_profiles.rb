# frozen_string_literal: true

class CreateExpenseProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :expense_profiles do |t|
    	t.integer :user_id, null: false
    	t.float :funds, default: 0
    	t.integer :starts_at_day, default: 1
    	t.boolean :can_alert, default: false
		  t.timestamps null: false
    end

    add_index :expense_profiles, :user_id
  end
end
