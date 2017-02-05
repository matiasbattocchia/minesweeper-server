class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.text :instance
      t.string :status

      t.timestamps
    end
  end
end
