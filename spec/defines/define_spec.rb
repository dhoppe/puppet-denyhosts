require 'spec_helper'

describe 'denyhosts::define', :type => :define do
  ['Debian'].each do |osfamily|
    let(:facts) {{
      :osfamily => osfamily,
    }}
    let(:pre_condition) { 'include denyhosts' }
    let(:title) { 'denyhosts.conf' }

    context "on #{osfamily}" do
      context 'when source file' do
        let(:params) {{
          :config_file_source => 'puppet:///modules/denyhosts/common/etc/denyhosts.conf',
        }}

        it do
          is_expected.to contain_file('define_denyhosts.conf').with({
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/denyhosts/common/etc/denyhosts.conf',
            'notify'  => 'Service[denyhosts]',
            'require' => 'Package[denyhosts]',
          })
        end
      end

      context 'when content string' do
        let(:params) {{
          :config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        }}

        it do
          is_expected.to contain_file('define_denyhosts.conf').with({
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'notify'  => 'Service[denyhosts]',
            'require' => 'Package[denyhosts]',
          })
        end
      end

      context 'when content template' do
        let(:params) {{
          :config_file_template => 'denyhosts/common/etc/denyhosts.conf.erb',
        }}

        it do
          is_expected.to contain_file('define_denyhosts.conf').with({
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'notify'  => 'Service[denyhosts]',
            'require' => 'Package[denyhosts]',
          })
        end
      end

      context 'when content template (custom)' do
        let(:params) {{
          :config_file_template     => 'denyhosts/common/etc/denyhosts.conf.erb',
          :config_file_options_hash => {
            'key' => 'value',
          },
        }}

        it do
          is_expected.to contain_file('define_denyhosts.conf').with({
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'notify'  => 'Service[denyhosts]',
            'require' => 'Package[denyhosts]',
          })
        end
      end
    end
  end
end
