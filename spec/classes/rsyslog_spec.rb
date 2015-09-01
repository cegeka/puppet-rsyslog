#!/usr/bin/env rspec

require 'spec_helper'

describe 'rsyslog' do

  shared_examples "standard rsyslog" do
    it { should contain_class 'rsyslog' }
    it { should contain_service('rsyslog').with_ensure('running') }
    it { should contain_package('rsyslog').with_ensure('present') }

    it { should contain_file('/var/log/messages').with(
      :ensure => 'file',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0644'
    )}

    it { should contain_file('/etc/rsyslog.d').with(
      :ensure => 'directory',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0755'
    )}
  end

  context 'with default params' do
    let (:params) { {} }

    it_behaves_like "standard rsyslog"

    it { should contain_file('/etc/rsyslog.conf').with(
      :ensure => 'file',
      :owner  => 'root',
      :group  => 'root',
      :source => 'puppet:///modules/rsyslog/rsyslog.conf',
      :mode   => '0644'
    )}
  end

  context 'with conffile => puppet:///public/test1.txt' do
    let (:params) { { :conffile => 'puppet:///public/test1.txt' } }

    it_behaves_like "standard rsyslog"

    it { should contain_file('/etc/rsyslog.conf').with(
      :ensure => 'file',
      :owner  => 'root',
      :group  => 'root',
      :source => 'puppet:///public/test1.txt',
      :mode   => '0644'
    )}
  end
end
