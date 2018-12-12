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

    	t.float :spends, default: 0

        t.boolean :is_active, default: true

		t.timestamps null: false
    end

    create_table :participants do |t|
		t.integer :participant_id, null: false
		t.integer :cycle_id, null: false
        t.float :total_due, default: 0.0
        t.float :total_owe, default: 0.0
    end

    add_index :expense_cycles, [:type, :owner_id]
    add_index :expense_cycles, [:type, :owner_id, :is_active], name: "exp_cyc_actv_idx"
    add_index :participants, [:participant_id, :cycle_id], name: "patcp_main_map_idx"

  end
end
