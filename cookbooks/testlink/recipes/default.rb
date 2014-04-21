# Sets up Testlink 1.9
# 
# Homepage: http://www.teamst.org/
# Installation guide: http://www.teamst.org/_tldoc/1.8/installation_manual.pdf
# -----------------------------

app_dir = "/var/www/testlink"
db = "testlink"
# TODO Move these elsewhere
db_pass = "m6w2msmV"
db_user = "testlink_db"

# -----------------------------

package "php5-mysql"

directory app_dir do
  mode "0644"
  group "root"
  owner "root"
  action :create
end

cookbook_file "/tmp/testlink-1.9.2.tar.gz" do
  source "testlink-1.9.2.tar.gz"
  mode 0755
  owner "root"
  group "root"
end

execute "File extraction and chown" do
  user "root"
  command "tar -xzf /tmp/testlink-1.9.2.tar.gz -C #{app_dir} &&
           chown -R root:root #{app_dir}/testlink-1.9.2"
end
execute "File moving" do
  user "root"
  command "mv #{app_dir}/testlink-1.9.2/* #{app_dir}"
end
execute "Perm/access fixing" do
  user "root"
  command "chown -R root:root #{app_dir} &&
           chmod -R 777 #{app_dir}/upload_area &&
           chmod -R 777 #{app_dir}/logs &&
           rm -rf #{app_dir}/testlink-1.9.2"
end

# Add DB and tables, user
execute "Database creation and configuration" do
  user "root"
  command "mysql -u root -proot -e 'CREATE DATABASE if not exists #{db}' &&
  mysql -u root -proot -e 'CREATE USER #{db_user}' &&
  mysql -u root -proot -e 'GRANT SELECT, INSERT, UPDATE, DELETE on #{db}.* to #{db_user}@\"localhost\" identified by \"#{db_pass}\"' &&
  mysql -u root -proot #{db} < #{app_dir}/install/sql/mysql/testlink_create_tables.sql &&
  mysql -u root -proot #{db} < #{app_dir}/install/sql/mysql/testlink_create_default_data.sql"
end

# PHP config file
cookbook_file "#{app_dir}/config_db.inc.php" do
  source "config_db.inc.php"
  mode 0755
  owner "root"
  group "root"
end

execute "remove install dir" do
  user "root"
  command "rm -rf #{app_dir}/install"
end

execute "Set app dir perms" do
  user "root"
  command "chown -R www-data:www-data #{app_dir} &&
           chmod -R 775 #{app_dir}"
end


# Install steps complete.
# Now go to http://IP/testlink/index.php
# Default creds: admin/admin
#
# ----------------------------------------
# TODO Mail config:
# Copy config.inc.php to custom_config.inc.php, fill out [SMTP]
# TODO Configure Apache for DNS
# TODO Add SSH users
# TODO iptables config
