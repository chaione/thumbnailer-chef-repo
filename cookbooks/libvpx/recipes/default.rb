#
# Cookbook Name:: libvpx
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "build-essential"
package "checkinstall"

package "libfaac-dev"
package "libmp3lame-dev"
package "libopencore-amrnb-dev"
package "libopencore-amrwb-dev"
package "libtheora-dev"
package "libvorbis-dev"
package "texi2html"
package "yasm"
package "zlib1g-dev"


directory "/tmp/libvpx" do
  action :create
end

git "Syncing libpvx" do
  repository "http://git.chromium.org/webm/libvpx.git"
  destination "/tmp/libvpx"
  action :sync
end

bash "Compiling libvpx" do
  cwd "/tmp/libvpx"
  code <<-EOH
    ./configure
    make
    sudo checkinstall --pkgname=libvpx --pkgversion="1:$(date +%Y%m%d%H%M)-git" --backup=no \
      --deldoc=yes --fstrans=no --default
  EOH
end
