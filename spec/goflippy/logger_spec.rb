# coding: utf-8

require 'spec_helper'

RSpec.describe GoFlippy::Logger do
  let(:klass) { described_class }

  describe '#logger' do
    context '@logger is nil' do
      it { expect(klass.logger).not_to be_nil }
    end
  end
end