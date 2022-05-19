module Condeco

  # access token
  # Evie core saves it in account also saves the xpiry period
  # Evie core calls this gem with access token
  #
  # Evie core finds out unauthorized and then refreshes access token
  # stores and calls
  class Error < StandardError; end

  class Client
    def initialize
    end

    HOST = "https://developer-api.condecosoftware.com/Developer_SDE/api/V1"

    attr_accessor :token, :subscription_key

    def authenticate!(password:,client_id:)
      # validation:
      #   both should be present
      # Execution:
      #   call authentication endpoint with password & client_id
      #   returns you accesstoken and expiry time
    end

    def get_region(country:)
      # call entities region fetch method
    end

    def get_location(country:)
      # call entities location fetch method
    end

    private

    def rest_client
      @_rest_client ||= RestClient::Resource.new(HOST, headers: auth_headers)
    end

    def auth_headers
      @_auth_headers ||= {
        "Ocp-Apim-Subscription-Key" => subscription_key,
        "Authorization" => token
      }
    end
  end
end