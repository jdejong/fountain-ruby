module Fountain
  #
  # Fountain Booked Slot
  #
  class BookedSlot
    # Raw booked slot data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw booked slot data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Booked slot ID
    def id
      raw_data['id']
    end

    # Start time
    def start_time
      Time.parse raw_data['start_time']
    end

    # End time
    def end_time
      Time.parse raw_data['end_time']
    end

    # Location
    def location
      raw_data['location']
    end

    # Recruiter
    def recruiter
      raw_data['recruiter']
    end

    # Instructions
    def instructions
      raw_data['instructions']
    end

    # Showed up
    def showed_up
      raw_data['showed_up'] == 'true'
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @id="%<id>s">',
        class_name: self.class.name,
        object_id: object_id,
        id: id
      )
    end
  end
end
