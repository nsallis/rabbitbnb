class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.string :name
      t.integer :votes, default: 0, null: false

      t.timestamps
    end
  end
end
