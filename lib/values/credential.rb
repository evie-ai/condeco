class Credential

  def initialize(access_token:, subscription_key:)
    raise ArgumentError unless access_token.present? && subscription_key.present?
    @access_token = access_token
    @subscription_key = subscription_key
  end

  attr_reader :subscription_key, :access_token

  def auth_headers
    {
      "Ocp-Apim-Subscription-Key" => subscription_key,
      "Authorization" => "Bearer #{access_token}",
      "Accept" => "*/*",
      "content_type" => "application/json"
    }
  end
end