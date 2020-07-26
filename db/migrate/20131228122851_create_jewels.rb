class CreateJewels < ActiveRecord::Migration[6.0]
  def change
    create_table :jewels do |t|
      t.string :source, :null => false, :default => ""
      t.string :citation, :null => false, :default => ""
      t.text :quote, :null => false, :default => ""
      t.text :comment, :null => false, :default => ""
    end
  end
end
