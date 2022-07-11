class RemoveGenderFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :gender, :integer
  end
end
