require 'securerandom'
require 'erb'
require 'fileutils'

module FromScratch
  def self.run!
    app_name, host = ARGV
    ssh_pub_key = `cat ~/.ssh/id_rsa.pub`.strip
    postgresql_admin_password = `echo -n '#{SecureRandom.base64(16)}''postgres' | openssl md5 | sed -e 's/.* /md5/'`.strip

    { node: ['nodes', host], user: ['data_bags/users', 'deploy'] }.each do |from, to|
      FileUtils.mkdir_p File.expand_path("../../tmp/#{to[0]}", __FILE__)
      File.open(File.expand_path("../../tmp/#{to.join('/')}.json", __FILE__), 'w') do |f|
        f.write ERB.new(File.open(File.expand_path("../../templates/#{from}.json.erb", __FILE__)).read).result(binding)
      end
    end

    Dir.chdir(File.expand_path('../..', __FILE__)) do
      system "knife solo bootstrap root@#{host} -c ./.chef/knife.rb"
      system "knife solo clean root@#{host} -c ./.chef/knife.rb"
    end

    FileUtils.rm_rf [File.expand_path('../../tmp', __FILE__)]
  end
end
