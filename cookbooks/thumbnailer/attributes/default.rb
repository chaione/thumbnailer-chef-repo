  # "default_attributes": {
  #   "thumbnailer": {
  #     "install_dir": "/var/app/thumbnailer",
  #     "user": "thumbnailer",
  #     "group": "thumbnailer",
  #     "hostname": "thumbnailer.gameplanhq.com",
  #     "port": 9999
  #   }
  # }

default['thumbnailer']['name'] = "thumbnailer"
default['thumbnailer']['install_dir'] = "/var/app/#{node['thumbnailer']['name']}"
default['thumbnailer']['user'] = node['thumbnailer']['name']
default['thumbnailer']['group'] = node['thumbnailer']['name']
default['thumbnailer']['hostname'] = 'thumbnailer.gameplanhq.com'
default['thumbnailer']['port'] = 9999