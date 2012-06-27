#!/usr/bin/env rspec

require 'spec_helper'

describe 'rsyslog' do
  it { should contain_class 'rsyslog' }
end
