# frozen_string_literal: true

RSpec.describe Monadix::Failure do
  let(:failure) { described_class.new("message", a: 1) }

  describe "#then" do
    it { expect(failure.then { nil }).to eq failure }
  end

  describe "#on_success" do
    it { expect(failure.on_success { nil }).to eq failure }
  end

  describe "#on_error" do
    it "calls the block in a chained fashion" do
      called = false
      res = failure.on_error do |msg, data|
        expect(msg).to eq "message"
        expect(data).to eq(a: 1)
        called = true
      end
      expect(called).to be true
      expect(res).to eq failure
    end
  end

  describe "#success?" do
    it { expect(failure.success?).to be false }
  end
end
