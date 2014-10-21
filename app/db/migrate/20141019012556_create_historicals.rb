class CreateHistoricals < ActiveRecord::Migration
  def change
    create_table :historicals do |t|

      t.timestamps
    end
  end
end
