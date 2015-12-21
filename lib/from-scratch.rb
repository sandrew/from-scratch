require 'securerandom'
require 'erb'
require 'fileutils'
require 'optparse'
require 'ostruct'

class FromScratch
  DEFAULTS = { ruby_installer: 'rvm', ruby_version: '2.2.4' }

  attr_accessor :options

  def initialize
    @options = OpenStruct.new DEFAULTS
  end

  def run!
    parse_options
    get_host_and_app_name
    generate_values

    { node: ['nodes', @options.host],
      user: ['data_bags/users', 'deploy']
    }.each do |from, to|
      FileUtils.mkdir_p File.expand_path("../../tmp/#{to[0]}", __FILE__)
      File.open(File.expand_path("../../tmp/#{to.join('/')}.json", __FILE__), 'w') do |f|
        f.write ERB.new(File.open(File.expand_path("../../templates/#{from}.json.erb", __FILE__)).read).result(binding)
      end
    end

    Dir.chdir(File.expand_path('../..', __FILE__)) do
      system "knife solo bootstrap root@#{@options.host} -c ./.chef/knife.rb"
      system "knife solo clean root@#{@options.host} -c ./.chef/knife.rb"
    end

    FileUtils.rm_rf [File.expand_path('../../tmp', __FILE__)]
  end

  def get_host_and_app_name
    @options.app_name, @options.host = ARGV.select { |x| !(x =~ /^\-/) }

    unless @options.app_name && @options.host
      raise ArgumentError, 'You should specify APP_NAME and HOST. Use --help for information.'
    end
  end

  def parse_options
    opt_parser = OptionParser.new do |args|
      args.banner = "Usage: scratchify your_app_name your.host.com [options]"

      args.on '--rbenv', 'Use RBENV instead of RVM' do
        @options.ruby_installer = 'rbenv'
      end

      args.on '--ruby [VERSION]', "Choose specific ruby version instead of latest MRI" do |ruby_version|
        @options.ruby_version = ruby_version
      end

      args.on '-h', '--help', 'Prints this help' do
        puts args
        exit
      end
    end

    opt_parser.parse!
  end

  def generate_values
    @options.ssh_pub_key               = `cat ~/.ssh/id_rsa.pub`.strip
    @options.postgresql_admin_password = `echo -n '#{SecureRandom.base64(16)}''postgres' | openssl md5 | sed -e 's/.* /md5/'`.strip
    @options.postgresql_user_password  = SecureRandom.base64(16)
  end
end
