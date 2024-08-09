class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :event
      t.string :inner
      t.string :outer
      t.string :review
      t.integer :user_id
      t.string :image
      t.integer :star
      t.datetime :start_time
      t.datetime :end_time
      t.string :category
      t.timestamps
    end
  end
end
