class AddRating3ToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :rating3, :integer
  end
end
