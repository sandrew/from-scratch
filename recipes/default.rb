["#{node['scratchify']['app_name']}", "#{node['scratchify']['app_name']}/shared", "#{node['scratchify']['app_name']}/shared/config", "#{node['scratchify']['app_name']}/shared/log"].each do |path|
  directory "/home/deploy/#{path}" do
    owner 'deploy'
    group 'deploy'
    mode '0755'
    recursive true
  end
end

directory "/home/deploy/#{node['scratchify']['app_name']}/shared/log" do
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

# required for json gem
if node['platform_family'] == 'debian'
  package 'libgmp-dev'
end
