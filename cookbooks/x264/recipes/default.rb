#
# Cookbook Name:: x264
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


directory "/tmp/x264" do
  action :create
end

git "Syncing x264" do
  repository "git://git.videolan.org/x264"
  destination "/tmp/x264"
  action :sync
end

bash "Compiling x264" do
  cwd "/tmp/x264"
  code <<-EOH
    ./configure --enable-static
    make
    sudo checkinstall --pkgname=x264 --pkgversion="3:$(./version.sh | \
      awk -F'[" ]' '/POINT/{print $4"+git"$5}')" --backup=no --deldoc=yes \
      --fstrans=no --default
  EOH
end
