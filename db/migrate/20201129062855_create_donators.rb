class CreateDonators < ActiveRecord::Migration[6.0]
  def change
    create_table :donators do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :about

      t.timestamps
    end
  end
end
