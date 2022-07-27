#!/usr/bin/env bash

cd /home/ec2-user/backend
npm ci
pm2 start index.js

cd /home/ec2-user/frontend
npm ci
pm2 start "npm start"
