class CreateRestHoras < ActiveRecord::Migration
  def change
    create_table :rest_horas do |t|
      t.string :categorie
      t.string :fel_mancare
      t.string :cantitate
      t.string :pret

      t.timestamps
    end
  end
end
