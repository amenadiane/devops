
# add nodejs to yum
# curl -sL https://rpm.nodesource.com/setup_lts.x | bash -
# yum install nodejs -y #default-jre ImageMagick

# Install NVM package manager for manager separate versions of nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh

# Install node 14
nvm install 14

# install pm2 module globaly
npm install -g pm2
pm2 update

# install nc utility
yum install nc -y

# delete existing bundle
cd /home/ec2-user
rm -rf backend
rm -rf fontend
