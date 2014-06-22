class Hugh < ActiveRecord::Base
  def spark_api
    Faraday.new url: "https://api.spark.io" do |conn|
      conn.request :authentication, "Bearer", spark_api_access_token
      conn.adapter Faraday.default_adapter
    end
  end

  def spark_color_string
    red, green, blue = [ color[0..1], color[2..3], color[4..5] ]
    "#{red},#{green},#{blue},#{brightness}"
  end
end
