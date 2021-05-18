class CreateShipInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :ship_infos do |t|
      t.string :post_code, null: false
      t.integer :area_id, null: false
      t.string :city, null: false
      t.string :house_number, null: false
      t.string :building
      t.string :phone_number, null: false
      t.references :item_record, null: false, foreign_keys: true
      t.timestamps
    end
  end
end
