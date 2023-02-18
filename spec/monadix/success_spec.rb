# frozen_string_literal: true

RSpec.describe Monadix::Success do
  let(:success) { described_class.new(data: true) }

  describe "#then" do
    it "calles the given block" do
      [described_class.new(a: 1), Monadix::Failure.new(b: 2)].each do |new_result|
        called = false
        res = success.then do |data|
          expect(data).to eq(data: true)
          called = true
          new_result
        end
        expect(res).to eq new_result
        expect(called).to be true
      end
    end

    it "raises an error when data is not a result object" do
      expect do
        success.then do
          Struct.new(:a).new(1)
        end
      end.to raise_error(ArgumentError, /must return a Success or Failure/)
    end
  end

  describe "#on_success" do
    it "calls the given block and returns self" do
      called = false
      res = success.on_success do |data|
        expect(data).to eq(data: true)
        called = true
      end
      expect(called).to be true
      expect(res).to eq success
    end
  end

  describe "#on_error" do
    it { expect(success.on_error { nil }).to eq success }
  end

  describe "#success?" do
    it { expect(success.success?).to be true }
  end
end
