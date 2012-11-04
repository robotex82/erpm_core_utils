class CreateTaxRates < ActiveRecord::Migration
  def change
    create_table :tax_rates do |t|
      t.string :name
      t.decimal :rate
      t.text :description
      
      # acts as masterdata
      t.string :creator_type
      t.integer :creator_id
      t.integer :parent_id
      t.integer :lft, :null => false
      t.integer :rgt, :null => false
      t.integer :depth
      t.integer :children_count, :default => 0, :null => false
      t.timestamp :live_from
      t.timestamp :live_to

      t.timestamps
    end
  end
end
