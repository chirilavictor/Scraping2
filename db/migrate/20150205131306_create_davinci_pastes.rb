class CreateDavinciPastes < ActiveRecord::Migration
  def change
    create_table :davinci_pastes do |t|
      t.string :fel_mancare
      t.integer :pret
      t.string :descriere
      t.string :cantitate

      t.timestamps
    end
  end
end
