name             "scratchify"
maintainer       "Andrew Shaydurov"
maintainer_email "gearhead@it-primorye.ru"
license          "MIT"
description      "Cookbook for FromScratch gem"
version          "0.1.0"

recipe "scratchify", "run all recipes."

supports 'ubuntu'
supports 'debian'

depends 'user'
depends 'rvm'
depends 'postgresql'
