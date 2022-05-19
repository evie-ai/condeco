module Condeco
  module Values
    class Country
      COUNTRY_LIST_TO_ID_MAP = {
        "singapore" => 21
      }.freeze

      COUNTRY_LIST_TO_ID_MAP.each do |country,id|
        define_singleton_method(country) {country}
      end

      def self.valid?(country)
        country.downcase.strip.in? COUNTRY_LIST_TO_ID_MAP.keys
      end

      def self.country_id(country)
        COUNTRY_LIST_TO_ID_MAP[country.downcase.strip]
      end
    end
  end
end
