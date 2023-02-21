module Condeco
  class Countries

    class InvalidCountryError < StandardError
    end

    def initialize(credential:,endpoint:)
      @credential = credential
      @endpoint = endpoint
    end

    attr_reader :credential,:endpoint

    API_PATH = "/countries"

    def get
      begin
        url = "#{endpoint}#{API_PATH}"
        response = RestClient.get url, credential.auth_headers
        JSON.parse(response.body) if response.code == 200
      rescue =>e
        raise e
      end
    end
  end
end
