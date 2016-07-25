# fantasy-impromptu-api
Back-end for a football/Olympics fantasy league

NodeJS over MySQL. Database-side is inherited from legacy project, API is a port of legacy PHP plus new features.

Assumes you've already installed ghost and high-heart as per installation instructions.

Uses some slightly hacky methods to use Ghost's private API to support programmatic submission of image-only posts.

## Installation

This is pretty manual at present, but I've only done this once and haven't bothered scripting it yet.

Frankly I don't expect anyone other than me ever to install this, so this is mostly for my own reference.

sudo yum install mysql-server
sudo service mysqld start
sudo chkconfig --level 345 mysqld on


git clone https://github.com/ArstanWhitebeard/fantasy-impromptu-api.git
sudo mv fantasy-impromptu-api /opt
npm install
mysql -uroot < db/olympics/set_up_schema.sql
mysql -uroot < db/olympics/set_up_live_data.sql
cp config.js.sample config.js


sudo chown -R fantasy:fantasy /opt/fantasy-impromptu-api
sudo mkdir -p /var/log/fantasy-impromptu-api
sudo useradd fantasy
sudo chown fantasy:fantasy /var/log/fantasy-impromptu-api/

(insert sqlite stuff)
$ cd /var/www/ghost/content/data
$ sqlite3 ghost-dev.db
INSERT INTO users (id,
                     uuid,
                     name,
                     slug,
                     password,
                     email,
                     image,
                     cover,
                     bio,
                     website,
                     location,
                     accessibility,
                     status,
                     language,
                     meta_title,
                     meta_description,
                     last_login,
                     created_at,
                     created_by,
                     updated_at,
                     updated_by)
              VALUES ('2',
                      '30443ade-312c-4842-aa3a-f6c0dcd056f7',
                      'api',
                      'api',
                      '$2a$10$mRscAWGe0GaRy4StuTecQ.bp/uJEOaUyy0SsJ90hrVLfmg6yHl57W',
                      'api@fantasyimpromptu.uk',
                      NULL,
                      NULL,
                      NULL,
                      '',
                      '',
                      NULL,
                      'active',
                      'en_US',
                      NULL,
                      NULL,
                      '2014-10-18 17:12:40',
                      '2014-10-18 12:55:44',
                      '1',
                      '2014-10-18 17:12:40',
                      '1');
INSERT INTO roles_users VALUES (2,3,2);
INSERT INTO clients (id, uuid, name, slug, secret, redirection_uri, logo, status, type, description, created_at, created_by, updated_at, updated_by) VALUES (4, 'foofoofoo', 'API hack access', 'api', 'YOURCLIENTSECRET',null, null, 'enabled','ua',null, 1464444576564, 1, 1464444576564, 1);

Now log into the ghost management front-end and change the password for the api user.

cp /opt/fantasy-impromptu-api/config.js.sample /opt/fantasy-impromptu-api/config.js
vim /opt/fantasy-impromptu-api/config.js   <-- edit credentials etc. to match the ones you just created

mkdir /var/www/ghost/content/images/uploads
chown fantasy:ghost /var/www/ghost/content/images/uploads
chmod 770 /var/www/ghost/content/images/uploads

sudo cp /opt/fantasy-impromptu-api/init/fantasy-impromptu* /etc/init.d
sudo chmod 755 /etc/init.d/fantasy-impromptu*

sudo service fantasy-impromptu-api start
sudo service fantasy-impromptu-image-api start
sudo service fantasy-impromptu-scraper start
sudo chkconfig --level 345 fantasy-impromptu-api on
sudo chkconfig --level 345 fantasy-impromptu-image-api on
sudo chkconfig --level 345 fantasy-impromptu-scraper on
