class CreateGroupEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :group_events do |t|
      t.boolean :draft, default: true, index: true, null: false
      t.string :name
      t.text :description
      t.date :start
      t.date :stop
      t.integer :duration, precision: 3
      t.float :latitude, precision: 8, scale: 5
      t.float :longitude, precision: 8, scale: 5
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
