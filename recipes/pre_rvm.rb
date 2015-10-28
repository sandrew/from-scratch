execute 'download RVM GPG key' do
  user "deploy"
  command "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
  environment 'HOME' => '/home/deploy'
end
