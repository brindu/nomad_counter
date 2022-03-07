class RenameExposedToPublishedForSlackPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :slack_posts, :exposed, :published
  end
end
