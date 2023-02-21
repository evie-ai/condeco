module Condeco
  class Authenticator

    # "https://developer-sde.condecosoftware.com/tokenproviderapi/token"

    def self.authenticate(password:, client_id:, endpoint:)
      raise ArgumentError unless password.present? && client_id.present?
      payload = { password: password, client_id: client_id, grant_type: "password" }
      headers = {content_type: "application/x-www-form-urlencoded"}
      begin
        data = RestClient.post(endpoint, payload, headers)
        JSON.parse(data.body)
      rescue => e
        raise e
      end
    end
  end
end
