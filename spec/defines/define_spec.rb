require 'spec_helper'

describe 'denyhosts::define', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:pre_condition) { 'include denyhosts' }
      let(:title) { 'denyhosts.conf' }

      context 'when source file' do
        let(:params) do
          {
            config_file_path: '/etc/denyhosts.2nd.conf',
            config_file_source: 'puppet:///modules/denyhosts/common/etc/denyhosts.conf'
          }
        end

        it do
          is_expected.to contain_file('define_denyhosts.conf').with(
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/denyhosts/common/etc/denyhosts.conf',
            'notify'  => 'Service[denyhosts]',
            'require' => 'Package[denyhosts]'
          )
        end
      end

      context 'when content string' do
        let(:params) do
          {
            config_file_path: '/etc/denyhosts.3rd.conf',
            config_file_string: '# THIS FILE IS MANAGED BY PUPPET'
          }
        end

        it do
          is_expected.to contain_file('define_denyhosts.conf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'notify'  => 'Service[denyhosts]',
            'require' => 'Package[denyhosts]'
          )
        end
      end

      context 'when content template' do
        let(:params) do
          {
            config_file_path: '/etc/denyhosts.4th.conf',
            config_file_template: 'denyhosts/common/etc/denyhosts.conf.erb'
          }
        end

        it do
          is_expected.to contain_file('define_denyhosts.conf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'notify'  => 'Service[denyhosts]',
            'require' => 'Package[denyhosts]'
          )
        end
      end

      context 'when content template (custom)' do
        let(:params) do
          {
            config_file_path: '/etc/denyhosts.5th.conf',
            config_file_template: 'denyhosts/common/etc/denyhosts.conf.erb',
            config_file_options_hash: {
              'key' => 'value'
            }
          }
        end

        it do
          is_expected.to contain_file('define_denyhosts.conf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'notify'  => 'Service[denyhosts]',
            'require' => 'Package[denyhosts]'
          )
        end
      end
    end
  end
end
