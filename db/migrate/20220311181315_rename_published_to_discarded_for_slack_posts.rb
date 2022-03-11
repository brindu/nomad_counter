class RenamePublishedToDiscardedForSlackPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :slack_posts, :published, :discarded
  end
end
