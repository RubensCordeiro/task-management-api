# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationTokenService do
  context 'when encoding and decoding' do
    let(:payload) { { 'username' => 'john_doe', 'foo' => 'bar' } }

    describe '.encode' do
      it 'performs JWT encoding' do
        token = described_class.encode(payload)
        expect(!token).to be(false)
      end
    end

    describe '.decode' do
      it 'decodes JWT token' do
        token = described_class.encode(payload)
        decoded_token = described_class.decode(token)
        expect(decoded_token[0]).to eq(payload)
      end
    end
  end
end
