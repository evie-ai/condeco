module Condeco
  class Bookings

    def initialize(credential:)
      @credential = credential
    end

    attr_reader :credential

    BOOK_ROOM_API_PATH = "https://developer-api.condecosoftware.com/Developer_SDE/api/V1/bookings"

    MEETING_ROOM_RESOURCE_TYPE = 1

    def book_room(room_id:, dtstart:, dtend:, user_id:, meeting_title:)
      raise ArgumentError("dtstart & dtend should be DateTime object") unless dtstart.is_a?(DateTime) && dtend.is_a?(DateTime)
      begin
        payload = {
          "roomId" => room_id,
          "startDateTime" => format_date_time(dtstart),
          "endDateTime" => format_date_time(dtend),
          "meetingTitle" => meeting_title,
          "userId" => user_id
        }
        params = {isUTCDateTime: true}
        headers = credential.auth_headers.merge(params: params)
        response = RestClient.post BOOK_ROOM_API_PATH, payload, headers
        JSON.parse(response.body) if response.code.to_s.start_with?("2")
      rescue => e
        raise e
      end
    end

    def get(booking_id:)
      path = "#{BOOK_ROOM_API_PATH}/#{booking_id}"
      response = RestClient.get path, credential.auth_headers
      JSON.parse(response.body)
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

    def update_booking(booking_id:,room_id:, dtstart:, dtend:, user_id:, meeting_title:)
      raise ArgumentError("dtstart & dtend should be DateTime object") unless dtstart.is_a?(DateTime) && dtend.is_a?(DateTime)

      update_path = "#{BOOK_ROOM_API_PATH}/#{booking_id}"
      begin
        payload = {
          "bookingDetails" => {
            "roomId" => room_id,
            "startDate" => format_date_time(dtstart),
            "endDate" => format_date_time(dtend),
            "meetingTitle" => meeting_title,
          },
          "userId" => user_id
        }
        params = {isUTCDateTime: true}
        headers = credential.auth_headers.merge(params: params)
        begin
            response = RestClient.put update_path, payload, headers
        rescue => e
          @error = e
        end


        response = RestClient::Request.execute(
          method: :put,
          url: update_path,
          payload: payload,
          headers: headers
        )
        JSON.parse(response.body) if response.code.to_s.start_with?("2")
      rescue => e
        raise e
      end
    end

    private

    def format_date_time(datetime)
      datetime.utc.strftime("%Y-%m-%d %H:%M:%S")
    end

  end
end