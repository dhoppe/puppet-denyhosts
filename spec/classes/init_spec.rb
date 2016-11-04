require 'spec_helper'

describe 'denyhosts', type: :class do
  ['Debian'].each do |osfamily|
    let(:facts) do
      {
        osfamily: osfamily
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_anchor('denyhosts::begin') }
    it { is_expected.to contain_class('denyhosts::params') }
    it { is_expected.to contain_class('denyhosts::install') }
    it { is_expected.to contain_class('denyhosts::config') }
    it { is_expected.to contain_class('denyhosts::service') }
    it { is_expected.to contain_anchor('denyhosts::end') }

    context "on #{osfamily}" do
      describe 'denyhosts::install' do
        context 'defaults' do
          it do
            is_expected.to contain_package('denyhosts').with(
              'ensure' => 'present'
            )
          end
        end

        context 'when package latest' do
          let(:params) do
            {
              package_ensure: 'latest'
            }
          end

          it do
            is_expected.to contain_package('denyhosts').with(
              'ensure' => 'latest'
            )
          end
        end

        context 'when package absent' do
          let(:params) do
            {
              package_ensure: 'absent',
              service_ensure: 'stopped',
              service_enable: false
            }
          end

          it do
            is_expected.to contain_package('denyhosts').with(
              'ensure' => 'absent'
            )
          end
          it do
            is_expected.to contain_file('denyhosts.conf').with(
              'ensure'  => 'present',
              'notify'  => 'Service[denyhosts]',
              'require' => 'Package[denyhosts]'
            )
          end
          it do
            is_expected.to contain_service('denyhosts').with(
              'ensure' => 'stopped',
              'enable' => false
            )
          end
        end

        context 'when package purged' do
          let(:params) do
            {
              package_ensure: 'purged',
              service_ensure: 'stopped',
              service_enable: false
            }
          end

          it do
            is_expected.to contain_package('denyhosts').with(
              'ensure' => 'purged'
            )
          end
          it do
            is_expected.to contain_file('denyhosts.conf').with(
              'ensure'  => 'absent',
              'notify'  => 'Service[denyhosts]',
              'require' => 'Package[denyhosts]'
            )
          end
          it do
            is_expected.to contain_service('denyhosts').with(
              'ensure' => 'stopped',
              'enable' => false
            )
          end
        end
      end

      describe 'denyhosts::config' do
        context 'defaults' do
          it do
            is_expected.to contain_file('denyhosts.conf').with(
              'ensure'  => 'present',
              'notify'  => 'Service[denyhosts]',
              'require' => 'Package[denyhosts]'
            )
          end
        end

        context 'when source dir' do
          let(:params) do
            {
              config_dir_source: 'puppet:///modules/denyhosts/common/etc'
            }
          end

          it do
            is_expected.to contain_file('denyhosts.dir').with(
              'ensure'  => 'directory',
              'force'   => false,
              'purge'   => false,
              'recurse' => true,
              'source'  => 'puppet:///modules/denyhosts/common/etc',
              'notify'  => 'Service[denyhosts]',
              'require' => 'Package[denyhosts]'
            )
          end
        end

        context 'when source dir purged' do
          let(:params) do
            {
              config_dir_purge: true,
              config_dir_source: 'puppet:///modules/denyhosts/common/etc'
            }
          end

          it do
            is_expected.to contain_file('denyhosts.dir').with(
              'ensure'  => 'directory',
              'force'   => true,
              'purge'   => true,
              'recurse' => true,
              'source'  => 'puppet:///modules/denyhosts/common/etc',
              'notify'  => 'Service[denyhosts]',
              'require' => 'Package[denyhosts]'
            )
          end
        end

        context 'when source file' do
          let(:params) do
            {
              config_file_source: 'puppet:///modules/denyhosts/common/etc/denyhosts.conf'
            }
          end

          it do
            is_expected.to contain_file('denyhosts.conf').with(
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
              config_file_string: '# THIS FILE IS MANAGED BY PUPPET'
            }
          end

          it do
            is_expected.to contain_file('denyhosts.conf').with(
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
              config_file_template: 'denyhosts/common/etc/denyhosts.conf.erb'
            }
          end

          it do
            is_expected.to contain_file('denyhosts.conf').with(
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
              config_file_template: 'denyhosts/common/etc/denyhosts.conf.erb',
              config_file_options_hash: {
                'key' => 'value'
              }
            }
          end

          it do
            is_expected.to contain_file('denyhosts.conf').with(
              'ensure'  => 'present',
              'content' => %r{THIS FILE IS MANAGED BY PUPPET},
              'notify'  => 'Service[denyhosts]',
              'require' => 'Package[denyhosts]'
            )
          end
        end
      end

      describe 'denyhosts::service' do
        context 'defaults' do
          it do
            is_expected.to contain_service('denyhosts').with(
              'ensure' => 'running',
              'enable' => true
            )
          end
        end

        context 'when service stopped' do
          let(:params) do
            {
              service_ensure: 'stopped'
            }
          end

          it do
            is_expected.to contain_service('denyhosts').with(
              'ensure' => 'stopped',
              'enable' => true
            )
          end
        end
      end
    end
  end
end
