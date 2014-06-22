class CreateHughs < ActiveRecord::Migration
  def change
    create_table :hughs do |t|
      t.string :spark_core_id
      t.string :spark_api_access_token
      t.string :color
      t.integer :brightness

      t.timestamps
    end
  end
end
