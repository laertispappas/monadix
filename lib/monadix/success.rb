# frozen_string_literal: true

module Monadix
  class Success
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def then
      yield(data).tap do |result|
        Result.assert!(result)
      end
    end

    def on_success
      yield(data)
      self
    end

    def on_error
      self
    end

    def success?
      true
    end
  end
end
