class CleverTap
  # Normalize the success response data to one interface with the failure one
  class SuccessfulResponse
    attr_reader :raw_response, :unprocessed, :message, :code

    # NOTE: raw_response can include processed, unprocessed, status
    def initialize(raw_response = {})
      @raw_response = raw_response
      @unprocessed = raw_response['unprocessed']
      @message = ''
      @code = 200
    end

    def errors
      unprocessed
    end

    def status
      case
      when success then 'success'
      when raw_response['processed'].positive? then 'partial'
      else 'fail'
      end
    end

    def success
      unprocessed.empty?
    end
  end
end
