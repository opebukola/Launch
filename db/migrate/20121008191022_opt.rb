class Opt < ActiveRecord::Migration
  def change
  	remove_column :users, :opt_in
  end
end
