# frozen_string_literal: true

module Monadix
  module Result
    def self.assert!(res)
      return if res.is_a?(Monadix::Success) || res.is_a?(Monadix::Failure)

      raise ArgumentError, "Block must return a Success or Failure object"
    end

    def self.all(*pipeline)
      pipeline.inject(Monadix::Success.new([])) do |res, op|
        res.then do |res_data|
          op_res = op.call(*res_data)
          Result.assert!(op_res)
          op_res.then do |op_res_data|
            Monadix::Success.new(res_data.concat([op_res_data]))
          end
        end
      end
    end
  end
end
