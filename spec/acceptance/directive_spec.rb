require 'spec_helper_acceptance'

describe 'rsyslog::config::directives' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        class { '::rsyslog': }

        rsyslog::config::directives { 'disable_rate_limiting':
          content => [
            '\$SystemLogRateLimitInterval 0',
          ]
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/etc/rsyslog.d/disable_rate_limiting.conf' do
      it { is_expected.to be_file }
      its(:content) { should contain /SystemLogRateLimitInterval/ }
    end

  end
end

