class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.references :slack_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
