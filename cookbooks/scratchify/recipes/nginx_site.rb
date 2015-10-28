nginx_site node['scratchify']['app_name'] do
  enable true
  template 'nginx.erb'
end
