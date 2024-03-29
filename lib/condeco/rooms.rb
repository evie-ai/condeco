module Condeco
  class Rooms
    def initialize(credential:,endpoint:)
      @credential = credential
      @endpoint = endpoint
    end

    attr_reader :credential, :endpoint

    DISCOVER_ROOM_API_PATH = "/rooms"
    QUERY_ROOM_API_PATH = "/bookings/freeslots"

    MEETING_ROOM_RESOURCE_TYPE = 1

    def get(location_id:)
      begin
        params = {params: {"locationId" => location_id, extendedDetails: true}}
        url = "#{endpoint}#{DISCOVER_ROOM_API_PATH}"
        response = RestClient.get url, credential.auth_headers.merge(params)
        JSON.parse(response.body) if response.code == 200
      rescue =>e
        raise e
      end
    end

    def available_rooms(location_id:,dtstart:,dtend:,floor_id:)
      raise ArgumentError("dtstart & dtend should be DateTime object") unless dtstart.is_a?(DateTime) && dtend.is_a?(DateTime)
      begin
        params = {

              "locationId" => location_id,
              "startDateTime" => dtstart.rfc3339,
              "endDateTime" => dtend.rfc3339,
              "floorNumber" => floor_id,
              "resourceType" => MEETING_ROOM_RESOURCE_TYPE,
              "isUTCDateTime" => true
        }
        headers = credential.auth_headers.merge(params: params)
        url = "#{endpoint}#{QUERY_ROOM_API_PATH}"
        response = RestClient.get url, headers
        JSON.parse(response.body) if response.code == 200
      rescue =>e
        raise e
      end
    end

    private

  end
end