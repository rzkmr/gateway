class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.integer :service_id,   null: false
      t.string  :verb,         null: false
      t.string  :url_pattern,  null: false
      t.string  :version,      null: false

      t.timestamps
    end
  end
end
