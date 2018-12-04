# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
    	
		t.string :type, null: false
    	
    	t.integer :owner_id, null: false
    	
    	t.integer :parent_id

    	t.integer :expense_cycle_id, null: false
    	t.string :expense_cycle_type, null: false

    	t.integer :spends, default: 0

    	t.integer :expense_type_id , null: false

		t.timestamps null: false
    end

    add_index :expenses, [:type, :owner_id]
    add_index :expenses, [:type, :parent_id]
    add_index :expenses, [:type, :expense_cycle_id,:expense_cycle_type], name: "exp_cyc_poly_idx"

  end
end
