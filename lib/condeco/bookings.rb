module Condeco
  class Bookings

    def initialize(credential:)
      @credential = credential
    end

    attr_reader :credential

    BOOK_ROOM_API_PATH = "https://developer-api.condecosoftware.com/Developer_SDE/api/V1/bookings/"

    MEETING_ROOM_RESOURCE_TYPE = 1

    def book_room(room_id:, dtstart:, dtend:, user_id:)
      raise ArgumentError("dtstart & dtend should be DateTime object") unless dtstart.is_a?(DateTime) && dtend.is_a?(DateTime)
      begin
        payload = {
          "roomId" => room_id,
          "startDateTime" => dtstart.rfc3339,
          "endDateTime" => dtend.rfc3339,
          "userId" => user_id
        }
        response = RestClient.post BOOK_ROOM_API_PATH, payload, credential.auth_headers
        JSON.parse(response.body) if response.code.to_s.start_with?("2")
      rescue => e
        raise e
      end
    end

    def delete_booking(booking_id:, user_id:)
      begin
        params = {
          "bookingId" => booking_id,
          "userId" => user_id
        }
        RestClient::Request.execute(method: :delete, url: BOOK_ROOM_API_PATH,
          payload: params, headers: credential.auth_headers)
        {message: "Success"}
      rescue => e
        raise e
      end
    end

  end
end