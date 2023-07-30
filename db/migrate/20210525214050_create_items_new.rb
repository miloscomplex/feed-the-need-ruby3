class CreateItemsNew < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.belongs_to :donator, foreign_key: true
      t.belongs_to :needy, foreign_key: true
      t.timestamps
    end
  end
end
