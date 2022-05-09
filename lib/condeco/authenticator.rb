module Condeco
  class Authenticator

    AUTHENTICATOR_URL = "https://developer-sde.condecosoftware.com/tokenproviderapi/token"

    def self.authenticate(password:, client_id:)
      raise ArgumentError unless password.present? && client_id.present?
      payload = { password: password, client_id: client_id, grant_type: "password" }
      headers = {content_type: "application/x-www-form-urlencoded"}
      begin
        data = RestClient.post(AUTHENTICATOR_URL, payload, headers)
        JSON.parse(data.body)
      rescue => e
        raise e
      end
    end
  end
end
