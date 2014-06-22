class Hugh < ActiveRecord::Base
  validates :color, format: /[0-9a-f]{6}/
  validates :brightness, numericality: true
  validates :spark_core_id, :spark_api_access_token, :wink_user_id, presence: true
end
