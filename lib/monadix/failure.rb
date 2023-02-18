# frozen_string_literal: true

module Monadix
  class Failure
    attr_reader :data, :error_msg

    def initialize(error_msg, data = nil)
      @error_msg = error_msg
      @data = data
    end

    def then
      self
    end

    def on_success
      self
    end

    def on_error
      yield(error_msg, data)
      self
    end

    def success?
      false
    end
  end
end
