# frozen_string_literal: true

class CreateExpenseCycles < ActiveRecord::Migration[5.1]
  def change
    create_table :expense_cycles do |t|
    	t.integer :owner_id, null: false
    	t.string :title, null: false
    	t.text :description

    	t.string :type, null: false

    	t.datetime :starts_at
    	t.datetime :expires_at

    	t.boolean :is_active, default: true

		t.timestamps null: false
    end

    create_table :participants, id: false do |t|
		t.integer :participant_id, null: false
		t.integer :shared_expense_cycle_id, null: false
    end

    add_index :expense_cycles, [:type, :owner_id]
    add_index :expense_cycles, [:type, :owner_id, :is_active], name: "exp_cyc_actv_idx"
    add_index :participants, [:participant_id, :shared_expense_cycle_id], name: "patcp_main_map_idx"

  end
end
