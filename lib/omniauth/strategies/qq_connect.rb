require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class QqConnect < OmniAuth::Strategies::OAuth2
      option :name, "qq_connect"

      option :client_options, {
          :site => 'https://graph.qq.com/oauth2.0/',
          :authorize_url => '/oauth2.0/authorize',
          :token_url => "/oauth2.0/token",
          :token_formatter => lambda {|hash|
            hash[:expires_in] = hash['expires_in'].to_i
            hash.delete('expires_in')
          }
      }

      option :token_params, {
          :state => 'foobar',
          :parse => :query
      }

      uid do
        @uid ||= begin
                   access_token.options[:mode] = :query
                   access_token.options[:param_name] = :access_token
                   # Response Example: "callback( {\"client_id\":\"11111\",\"openid\":\"000000FFFF\"} );\n"

                   response = access_token.get('/oauth2.0/me')
                   #TODO handle error case

                   matched = response.body.match(/"openid":"(?<openid>\w+)"/)
                   matched[:openid]
                 end
      end

      info do
        {
            :nickname => raw_info['nickname'],
            :name => raw_info['nickname'],
            :image => raw_info['figureurl_1'],
        }
      end

      extra do
        {
            :raw_info => raw_info
        }
      end

      def raw_info
        @raw_info ||= begin
                        client.request(:get, "https://graph.qq.com/user/get_user_info", :params => {
                            :format => :json,
                            :openid => uid,
                            :oauth_consumer_key => options[:client_id],
                            :access_token => access_token.token
                        }, :parse => :json).parsed
                      end
      end
    end
  end
end

OmniAuth.config.add_camelization('qq_connect', 'QqConnect')
