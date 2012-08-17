#
# Cookbook Name:: thumbnailer
# Recipe:: default
#
# Copyright 2012, ChaiONE
#
# All rights reserved - Do Not Redistribute
#

user "Creating #{node['thumbnailer']['user']} User" do
  username node['thumbnailer']['user']
  action :create
  shell "/bin/bash"
  supports({:manage_home => true})
end

group "Creating #{node['thumbnailer']['group']} Group" do
  group_name node['thumbnailer']['group']
  action :create
  members [node['thumbnailer']['user']]
  append true
end

directory "Creating app directory for #{node['thumbnailer']['install_dir']}" do
  action :create
  owner node['thumbnailer']['user']
  group node['thumbnailer']['group']
  path  node['thumbnailer']['install_dir']
  mode '0775'
  recursive true
end

template "Adding apache proxy" do
  action :create
  path "#{node['apache']['dir']}/sites-available/thumbnailer-proxy"
  source "thumbnailer-proxy.erb"
end

service "apache2" do
  supports :restart => true, :reload => true
  action :restart
end