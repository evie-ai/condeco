module Condeco
  class Location
    def initialize(credential:)
      @credential = credential
    end

    attr_reader :credential

    API_PATH = "https://developer-api.condecosoftware.com/Developer_SDE/api/V1/locations"

    def get(region:)
      begin
        params = {params: {"regionId" => region}}
        response = RestClient.get API_PATH, credential.auth_headers.merge(params)
        JSON.parse(response.body) if response.code == 200
      rescue =>e
        raise e
      end
    end
  end
end
