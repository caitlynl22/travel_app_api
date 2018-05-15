class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.belongs_to :trip, index: true
      t.belongs_to :location, index: true

      t.timestamps
    end
  end
end
