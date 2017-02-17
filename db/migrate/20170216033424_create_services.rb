class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :name,   null: false
      t.string :url,    null: false
      t.string :token

      t.timestamps
    end
  end
end
