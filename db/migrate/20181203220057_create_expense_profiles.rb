# frozen_string_literal: true

class CreateExpenseProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :expense_profiles do |t|
    	t.integer :user_id, null: false
    	t.integer :funds, null: false
    	t.integer :starts_at_day, null: false
    	t.boolean :can_alert, null: false
		t.timestamps null: false
    end

    add_index :expense_profiles, :user_id
  end
end
