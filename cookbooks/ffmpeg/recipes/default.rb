#
# Cookbook Name:: ffmpeg
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Source: https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide

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

directory "/tmp/ffmpeg" do
  action :create
end

git "Syncing ffmpeg" do
  depth 1
  repository "git://source.ffmpeg.org/ffmpeg"
  destination "/tmp/ffmpeg"
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

execute "hash x264 ffmpeg ffprobe"
