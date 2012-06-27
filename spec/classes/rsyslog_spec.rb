#!/usr/bin/env rspec

require 'spec_helper'

describe 'rsyslog' do
  it { should contain_class 'rsyslog' }
  it { should contain_service('rsyslog').with_ensure('running') }
  it { should contain_package('rsyslog').with_ensure('latest') }
	it { should contain_file('/etc/rsyslog.conf').with({
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
  })}
  it { should contain_file('/var/log/messages').with({
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
  })}
end
