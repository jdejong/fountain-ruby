# frozen_string_literal: true

module Fountain
  #
  # Fountain Document Upload
  #
  class DocumentUpload
    # Raw document data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw document upload data
    #
    def initialize(data)
      _sub_data = data.extract!(:form_data)
      @raw_data = Util.stringify_hash_keys data.merge(_sub_data[:form_data])
    end

    def url
      raw_data['url']
    end

    def host
      raw_data['host']
    end

    def key
      raw_data['key']
    end


  end
end
