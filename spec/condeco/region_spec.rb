describe Condeco::Region do
  let(:invalid_credential) { Credential.new(access_token: "invalid", subscription_key: "subs") }
  let(:valid_credential) { Credential.new(access_token: "valid", subscription_key: "subs") }

  describe "#get" do
    context "when country is invalid" do
      it "raises InvalidCountryError" do
        expect {
          described_class.new(credential: valid_credential).get(country: "india")
        }.to raise_error(Condeco::Region::InvalidCountryError)
      end
    end

    context "when country is valid" do
      it "raises InvalidCountryError" do
        # load fixtures on restclient call
        expect {
          described_class.new(credential: valid_credential).get(country: "india")
        }.to raise_error(Condeco::Region::InvalidCountryError)
      end
    end
  end
end
