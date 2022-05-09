module Condeco
  class Region

    class InvalidCountryError < StandardError
    end

    def initialize(credential:)
      @credential = credential
    end

    attr_reader :credential

    API_PATH = "https://developer-api.condecosoftware.com/Developer_SDE/api/V1/regions"

    def get(country:)
      raise InvalidCountryError unless Country.valid?(country)
      begin
        params = {params: {"countryId" => Country.country_id(country)}}
        response = RestClient.get API_PATH, credential.auth_headers.merge(params)
        JSON.parse(response.body) if response.code == 200
      rescue =>e
        raise e
      end
    end
  end
end
