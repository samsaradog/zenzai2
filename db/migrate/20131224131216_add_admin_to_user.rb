class AddAdminToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_admin, :boolean, :null => false, :default => false
    add_column :users, :gets_daily_dharma, :boolean, :null => false, :default => false
  end
end
