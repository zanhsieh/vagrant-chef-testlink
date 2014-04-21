name "testlink-server"
description "Instance of TestLink (QA application)"

run_list(
  "recipe[vim]",
  "recipe[openssl::default]",
  "recipe[mysql::server]",
  "recipe[apache2]",
  # PHP5.2 for 1.8, 5.2/5.3 for 1.9
  "recipe[apache2::mod_php5]",
  "recipe[apache2::mod_rewrite]",
  "recipe[testlink]"
) 

override_attributes(
  :apache => {
    "default_site_enabled" => true
  },
  :mysql => {
    "server_root_password" => "root",
    "bind_address" => "127.0.0.1",
    "version" => ">4.1"
    # If default innodb_flush_method value is desired, do nothing.
    # If a particular value is desired you can add it back 
    # to mysql cookbook server attrs and my.cnf.erb and set it.
    # Passing the old default value will result in an error.
  }
)
