name "thumbnailer"
description "A restful thumbnailing service"
run_list 'apache2', 'apache2:mod_proxy', 'x264', 'libpvx', 'ffmpeg', 'thumbnailer'
default_attributes {
  :thumbnailer => {
    :name => "thumbnailer",
    :install_dir => "/var/app/thumbnailer",
    :user => "thumbnailer",
    :group => "thumbnailer",
    :hostname => "thumbnailer.gameplanhq.com",
    :port => "9999"
  }
}