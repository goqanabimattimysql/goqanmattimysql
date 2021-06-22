fx_version 'adamant'
game 'common'

name 'goqanmattim'
description 'Gökan abimin yaptığı sql'
author 'Göqan abi (ayakkabından su içilir)'
version '1.3.2'
url 'https://github.com/GHMatti/ghmattimysql'

server_scripts {
  'goqanmattim-server.js',
  'goqanmattim-server.lua',
}

client_script 'goqanmattim-client.lua'

files {
  'ui/index.html',
  'ui/js/app.js',
  'ui/css/app.css',
  'ui/fonts/*.woff',
  'ui/fonts/*.woff2',
  'ui/fonts/*.eot',
  'ui/fonts/*.ttf',
}

ui_page 'ui/index.html'
