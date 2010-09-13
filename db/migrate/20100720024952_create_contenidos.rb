class CreateContenidos < ActiveRecord::Migration
  def self.up
    create_table :contenidos do |t|
      t.string :redenderer
      t.integer :ubicacion
      t.integer :tiempo_muestreo
      t.integer :tipo

      t.timestamps
    end
  end

  def self.down
    drop_table :contenidos
  end
end
