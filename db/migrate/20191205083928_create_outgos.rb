class CreateOutgos < ActiveRecord::Migration[5.1]
  def change
    create_table :outgos do |t|
      t.integer :amount
      t.string :categories
      t.string :memo
      t.datetime :date
      t.integer :user_id

      t.timestamps
    end
  end
end
