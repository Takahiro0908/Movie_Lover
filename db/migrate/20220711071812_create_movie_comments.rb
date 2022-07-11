class CreateMovieComments < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
