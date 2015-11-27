require 'spec_helper'

describe FromScratch do
  let(:instance) { described_class.new }
  let(:app_name) { 'my_app' }
  let(:host)     { 'host.example.com' }

  describe '::new' do
    subject { instance }

    its('options.to_h') { are_expected.to eq(described_class::DEFAULTS) }
  end

  describe '#get_host_and_app_name' do
    before do
      stub_const 'ARGV', argv
    end

    subject { instance.options }

    context 'with app_name and host' do
      before { instance.get_host_and_app_name }
      let(:argv) { [app_name, host] }

      its(:app_name) { is_expected.to eq(app_name) }
      its(:host) { is_expected.to eq(host) }
    end

    context 'without one of app_name or host' do
      let(:argv) { [app_name] }

      it 'should raise' do
        expect do
          instance.get_host_and_app_name
        end.to raise_error(ArgumentError)
      end

      context 'and with --option' do
        let(:argv) { [app_name, '--option'] }

        it 'should raise' do
          expect do
            instance.get_host_and_app_name
          end.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe '#parse_options' do
    before do
      stub_const 'ARGV', argv
      instance.parse_options
    end

    subject { instance.options }

    context 'with --rbenv' do
      let(:argv) { [app_name, host, '--rbenv'] }

      its(:ruby_installer) { is_expected.to eq('rbenv') }
    end
  end

  it 'has a version number' do
    expect(FromScratch::VERSION).not_to be nil
  end
end
