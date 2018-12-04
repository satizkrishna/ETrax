# frozen_string_literal: true

class CreateExpenseTypes < ActiveRecord::Migration[5.1]
  def change

    create_table :expense_types do |t|
    	t.integer :creator_id
    	
    	t.string :title, null: false
    	t.text :description, null: false
		
		t.timestamps null: false
    end

    add_index :expense_types, :creator_id

  end
end
