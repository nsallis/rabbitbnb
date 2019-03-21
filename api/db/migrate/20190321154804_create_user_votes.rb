class CreateUserVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_votes do |t|
      t.string :first_name
      t.string :last_name
      t.string :voted_for

      t.timestamps
    end
  end
end
