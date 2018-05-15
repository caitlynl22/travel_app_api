class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :title
      t.date :from
      t.date :to
      t.text :description

      t.timestamps
    end
  end
end
