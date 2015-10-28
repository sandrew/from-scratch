name             "scratchify"
maintainer       "Andrew Shaydurov"
maintainer_email "gearhead@it-primorye.ru"
license          "MIT"
description      "Cookbook for FromScratch gem"
version          "0.1.0"

recipe "scratchify", "sets up some user directories and files"
recipe "nginx_site", "loads nginx site config"

supports 'ubuntu'
supports 'debian'

depends 'user'
depends 'rvm'
depends 'postgresql'
depends 'nginx'
