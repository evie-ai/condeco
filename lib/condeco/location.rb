module Condeco
  class Location
    def initialize(credential:,endpoint:)
      @credential = credential
      @endpoint = endpoint
    end

    attr_reader :credential, :endpoint

    API_PATH = "/locations"

    def get(region:)
      begin
        params = {params: {"regionId" => region}}
        url = "#{endpoint}#{API_PATH}"
        response = RestClient.get url, credential.auth_headers.merge(params)
        JSON.parse(response.body) if response.code == 200
      rescue =>e
        raise e
      end
    end
  end
end
