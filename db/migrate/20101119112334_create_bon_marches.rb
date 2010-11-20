class CreateBonMarches < ActiveRecord::Migration
  def self.up
    create_table :bon_marches do |t|
      t.text :brand
      t.text :category
      t.text :interest
      t.text :store
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :bon_marches
  end
end
