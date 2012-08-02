#
# Cookbook Name:: libvpx
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


directory "/tmp/libvpx" do
  action :create
end

git "Syncing libpvx" do
  repository "git://git.chromium.org/webm/libvpx.git"
  destination "/tmp/ffmpeg-install/libvpx"
  action :sync
end

bash "Compiling libvpx" do
  cwd "/tmp/ffmpeg-install/libvpx"
  code <<-EOH
    ./configure
    make
    sudo checkinstall --pkgname=libvpx --pkgversion="1:$(date +%Y%m%d%H%M)-git" --backup=no \
      --deldoc=yes --fstrans=no --default
  EOH
end
