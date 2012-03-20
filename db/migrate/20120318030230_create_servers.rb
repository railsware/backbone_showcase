class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string        :name, :null => false
      t.integer       :sort_index, :default => 0
      t.string        :token, :null => false
      t.timestamps
    end
    add_index :servers, :token, :unique => true
  end
end
