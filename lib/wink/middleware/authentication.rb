module Wink
  module Middleware
    class Authentication
      def initialize app
        @app = app
      end

      def call env
        wink = Faraday.new url: "https://winkapi.quirky.com/" do |conn|
          conn.request :authorization, "Bearer", env['HTTP_AUTHORIZATION'].split.last
          conn.adapter Faraday.default_adapter
        end

        response = wink.get('/users/me')
        if response.success?
          user = JSON.parse response.body
          env['auth.wink.user_id'] = user['data']['user_id']

          @app.call env
        else
          [ 401, {}, "" ]
        end
      end
    end
  end
end
