module Wink
  module Middleware
    class Authentication
      def initialize app
        @app = app
      end

      def call env
        wink = Faraday.new url: "https://winkapi.quirky.com/" do |conn|
          conn.request :authorization, :token, env['HTTP_AUTHORIZATION'].split.last
          conn.adapter Faraday.default_adapter
        end

        response = JSON.parse wink.get('/users/me').body
        env['auth.wink.user_id'] = response['data']['user_id']

        @app.call env
      end
    end
  end
end
