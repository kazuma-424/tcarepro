class CreatePrefectures < ActiveRecord::Migration[5.1]
  def change
    create_table :prefectures do |t|
    t.string :labor
    t.string :product_type
    t.string :method
    t.integer :tel
    t.string :post
    t.string :address
    t.string :point

      t.timestamps
    end
  end
end
