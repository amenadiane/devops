# add nodejs to yum
curl -sL https://rpm.nodesource.com/setup_lts.x | bash -
yum install nodejs -y #default-jre ImageMagick

# install pm2 module globaly
npm install -g pm2
pm2 update

# install nc utility
yum install nc -y

# delete existing bundle
cd /home/ec2-user
rm -rf backend
rm -rf fontend
