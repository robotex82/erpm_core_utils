class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :net_price_cents
      t.references :tax_rate

      t.timestamps
    end
    add_index :line_items, :tax_rate_id
  end
end
