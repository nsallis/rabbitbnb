class AddVoterNamesToRating < ActiveRecord::Migration[5.2]
  def change
    add_column :ratings, :voters, :text, array: true, default: []
  end
end
