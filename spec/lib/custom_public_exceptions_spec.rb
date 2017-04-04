require 'rails_helper'

RSpec.describe CustomPublicExceptions do
  describe '#call' do
    subject { described_class.new(Rails.public_path).call(env) }

    context 'the status is 403' do
      let(:env) { Rack::MockRequest.env_for('/403') }
      it { is_expected.to be_instance_of(Array) }
      it { is_expected.to start_with 403 }
    end

    context 'the status is not 403' do
      let(:env) { Rack::MockRequest.env_for('/500') }
      it { is_expected.to be_instance_of(Array) }
      it { is_expected.to start_with 500 }
    end
  end
end
