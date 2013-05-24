class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string   :nick
      t.string   :url
      t.datetime :timestamp
    end
  end
end
