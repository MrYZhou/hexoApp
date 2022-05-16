#! /bin/bash
rm -rf ./public
# 静态文件

npm install
npm run  build
npm run  server