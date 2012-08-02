#
# Cookbook Name:: ffmpeg
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#package "build-essential"
package "checkinstall"
package "git-core"

package "libfaac-dev"
package "libmp3lame-dev"
package "libopencore-amrnb-dev"
package "libopencore-amrwb-dev"
package "libtheora-dev"
package "libvorbis-dev"
package "texi2html"
package "yasm"
package "zlib1g-dev"

directory "/tmp/ffmpeg-install" do
  action :create
  group "775"
  owner "775"
end

git "/tmp/ffmpeg-install/x264" do
  remote "git://git.videolan.org/x264"
  action :sync
end

bash "Compiling x264" do
  cwd "/tmp/ffmpeg-install/x264"
  code <<-EOH
    ./configure
    make
    sudo checkinstall --pkgname=x264 --pkgversion="3:$(./version.sh | \
    awk -F'[" ]' '/POINT/{print $4"+git"$5}')" --backup=no --deldoc=yes \
    --fstrans=no --default
  EOH
end

git "/tmp/ffmpeg-install/libvpx" do
  remote "git://git.chromium.org/webm/libvpx.git"
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

git "/tmp/ffmpeg-install/ffmpeg" do
  depth 1
  repository "git://source.ffmpeg.org/ffmpeg"
  action :sync
end

bash "Compiling ffmpeg" do
  cwd "/tmp/ffmpeg-install/ffmpeg"
  code <<-EOH
    ./configure --enable-gpl --enable-libfaac --enable-libmp3lame --enable-libopencore-amrnb \
      --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis --enable-libvpx \
      --enable-libx264 --enable-nonfree --enable-version3
    make
    sudo checkinstall --pkgname=ffmpeg --pkgversion="5:$(date +%Y%m%d%H%M)-git" --backup=no \
      --deldoc=yes --fstrans=no --default
  EOH
end

execute "hash x264 ffmpeg ffplay ffprobe"
