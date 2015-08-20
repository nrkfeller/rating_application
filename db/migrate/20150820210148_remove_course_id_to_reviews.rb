class RemoveCourseIdToReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :movie_id, :integer
  end
end
