require 'pry'

require 'active_support'
require 'active_support/core_ext/object'

require 'sshkit'

require 'from/scratch/version'
require 'from/scratch/interviewer'

module FromScratch
  def self.run!
    Interviewer.greetings

    host = Interviewer.get_host

    if host != 'localhost'
     `ssh-copy-id root@#{host}`
      root_host = SSHKit::Host.new "root@#{host}"
    else
      root_host = SSHKit::Host.new :local
    end

    SSHKit::Coordinator.new([root_host]).each do |host|
      execute 'adduser deploy --gecos "" --disabled-password'
      execute 'mkdir -p /home/deploy/.ssh/'
      execute 'cp -R ~/.ssh/authorized_keys /home/deploy/.ssh/'
      execute 'chown -R deploy:deploy /home/deploy/'
    end
  end
end
