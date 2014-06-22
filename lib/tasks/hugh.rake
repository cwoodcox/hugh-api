namespace :hugh do
  desc "Listen for updates from Spark devices"
  task listen: :environment do
    EM.run do
      Rails.logger.info "Starting EventSource listener..."

      sources = []
      Hugh.select(:spark_api_access_token).distinct.collect(&:spark_api_access_token).each do |token|
        Rails.logger.info "Listening for events from #{token}..."

        source = EventMachine::EventSource.new("https://api.spark.io/v1/devices/events/state", {}, { Authorization: "Bearer #{token}" })
        source.on 'state' do |message|
          color = message['data'].split(',')[0..2].reduce("") { |hex, int| hex + int.to_i.to_s(16).rjust(2, "0") }
          brightness = message['data'].split(',')[3]
          Hugh.where(spark_core_id: message['coreid']).update_all(color: color, brightness: brightness
        end

        source.start
        sources << source
      end
    end
  end
end
