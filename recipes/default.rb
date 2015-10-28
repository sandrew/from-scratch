directory "/home/deploy/#{node['scratchify']['app_name']}/shared/config" do
  owner 'deploy'
  group 'deploy'
  mode '0755'
  recursive true
end

template "/home/deploy/#{node['scratchify']['app_name']}/shared/config/database.yml" do
  source 'database.yml.erb'
  owner 'deploy'
  group 'deploy'
  mode '0600'
end

template "/home/deploy/#{node['scratchify']['app_name']}/shared/config/secrets.yml" do
  source 'secrets.yml.erb'
  owner 'deploy'
  group 'deploy'
  mode '0600'
end
