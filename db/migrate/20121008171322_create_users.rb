class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :opt_in, default: false

      t.timestamps
    end
  end
end
