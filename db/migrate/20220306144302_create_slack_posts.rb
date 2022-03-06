class CreateSlackPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :slack_posts do |t|
      t.string :external_id
      t.string :team_id
      t.string :user_id
      t.string :channel_id
      t.datetime :timestamp
      t.text :text
      t.boolean :exposed, default: false
      t.timestamps
    end
  end
end
