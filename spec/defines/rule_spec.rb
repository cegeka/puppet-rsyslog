#!/usr/bin/env rspec

require 'spec_helper'

describe 'rsyslog::rule' do
  context 'with title local7_remote' do
    let (:title) { 'local7_remote' }

    context 'on osfamily RedHat' do
      let (:facts) { {
        :osfamily => 'RedHat'
      } }

      context 'with required parameters' do
        let (:params) { {
          :facility    => 'local7',
          :destination => 'remote.host'
        } }

        it { should contain_rsyslog__rule('local7_remote').with(
          :facility    => 'local7',
          :level       => 'info',
          :destination => 'remote.host'
        )}

        it { should contain_file('/etc/rsyslog.d/local7_remote.conf').with(
          :ensure  => 'file',
          :owner   => 'root',
          :group   => 'root',
          :mode    => '0644',
          :content => /^local7.info[ \t]+remote.host$/
        )}
      end

      context 'with facility => local0, level => * and destination => /var/log/bla' do
        let (:params) { {
          :facility    => 'local0',
          :level       => '*',
          :destination => '/var/log/bla'
        } }

        it { should contain_file('/etc/rsyslog.d/local7_remote.conf').with(
          :ensure  => 'file',
          :owner   => 'root',
          :group   => 'root',
          :mode    => '0644',
          :content => /^local0.\*[ \t]+\/var\/log\/bla$/
        )}
      end
    end
  end
end
