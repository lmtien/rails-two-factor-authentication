class CreateTfas < ActiveRecord::Migration
  def change
    create_table :tfas do |t|
      t.references :user, index: true, foreign_key: true
      t.string :tfa_password_hash
      t.integer :attepmted

      t.timestamps null: false
    end
  end
end
