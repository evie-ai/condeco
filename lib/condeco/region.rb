module Condeco
  class Region

    class InvalidCountryError < StandardError
    end

    def initialize(credential:,endpoint:)
      @credential = credential
      @endpoint = endpoint
    end

    attr_reader :credential,:endpoint

    API_PATH = "/regions"

    def get(country_id:)
      begin
        params = {params: {"countryId" => country_id}}
        url = "#{endpoint}#{API_PATH}"
        response = RestClient.get url, credential.auth_headers.merge(params)
        JSON.parse(response.body) if response.code == 200
      rescue =>e
        raise e
      end
    end
  end
end
