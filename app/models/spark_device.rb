class SparkDevice
  attr_accessor :hugh

  extend Forwardable
  delegate [:color, :brightness, :spark_core_id, :spark_api_access_token] => :hugh

  def initialize hugh
    @hugh = hugh
  end

  def update
    Rails.logger.info "Updating Spark device #{spark_core_id}..."
    spark_api.post "command" do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = { params: spark_color_string }.to_json
    end
  end

  private
  def spark_api
    Faraday.new url: "https://api.spark.io/v1/devices/#{spark_core_id}" do |conn|
      conn.request :authorization, "Bearer", spark_api_access_token
      conn.adapter Faraday.default_adapter
    end
  end

  def spark_color_string
    [ color[0..1], color[2..3], color[4..5] ].collect { |hex| hex.to_i 16 }.push(brightness).join(",")
  end
end
