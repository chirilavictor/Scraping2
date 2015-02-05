class CreateDavinciDeserts < ActiveRecord::Migration
  def change
    create_table :davinci_deserts do |t|
      t.string :fel_mancare
      t.integer :pret
      t.string :descriere
      t.string :cantitate

      t.timestamps
    end
  end
end
