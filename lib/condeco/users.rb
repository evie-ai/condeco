module Condeco
  class Users

    class InvalidCountryError < StandardError
    end

    def initialize(credential:,endpoint:)
      @credential = credential
      @endpoint = endpoint
    end

    attr_reader :credential,:endpoint

    API_PATH = "/users"

    def get(email: nil)
      begin
        params = {}
        params["emailId"] = email if email.present?
        url = "#{endpoint}#{API_PATH}"
        response = RestClient.get url, credential.auth_headers.merge(params: params)
        JSON.parse(response.body) if response.code == 200
      rescue =>e
        raise e
      end
    end
  end
end
