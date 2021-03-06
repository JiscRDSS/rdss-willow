require 'spec_helper'

describe ::Rdss::Actors::HashChanged do
  let(:env) { nil }
  let(:empty_env) { '' }
  let(:populated_env) { 'populated' }

  it 'returns false if attribute not set' do
    expect(described_class.(env, populated_env)).to be_falsey
  end

  it 'returns true if attribute set but different' do
    expect(described_class.(empty_env, populated_env)).to be_truthy
  end

  it 'returns false if values are the same' do
    expect(described_class.(populated_env, 'populated')).to be_falsey
  end
end