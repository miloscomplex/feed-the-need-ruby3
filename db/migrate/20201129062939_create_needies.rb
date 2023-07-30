class CreateNeedies < ActiveRecord::Migration[6.0]
  def change
    create_table :needies do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :bio
      t.timestamps
    end
  end
end
