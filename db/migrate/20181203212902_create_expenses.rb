# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
    	
		t.string :type, null: false
        t.string :title, null: false
        t.text :description
    	
    	t.integer :owner_id, null: false
    	
    	t.integer :parent_id

    	t.integer :cycle_id, null: false
    	t.string :cycle_type, null: false

    	t.float :total_spends, default: 0
        t.float :expected_spends, default: 0
        t.float :recovered_spends, default: 0

    	t.integer :expense_type_id , null: false

		t.timestamps null: false
    end

    add_index :expenses, [:type, :owner_id]
    add_index :expenses, [:type, :parent_id]
    add_index :expenses, [:type, :cycle_id,:cycle_type], name: "exp_cyc_poly_idx"

  end
end
