class AddWinkUserIdToHughs < ActiveRecord::Migration
  def change
    change_table :hughs do |t|
      t.string :wink_user_id
    end
  end
end
