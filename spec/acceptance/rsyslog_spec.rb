require 'spec_helper_acceptance'

describe 'rsyslog' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include ::rsyslog
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/etc/rsyslog.conf' do
      it { is_expected.to be_file }
    end

  end
end

