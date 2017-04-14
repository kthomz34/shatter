class CreateEntries < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :meant_text
      t.text :care_text
      t.text :going_on_text
      t.text :bigger_picture_text
      t.datetime :publish_date
      t.timestamps
    end
  end
end
