require 'rubygems'
require 'active_record'
# Establishes the database connection
ActiveRecord::Base.establish_connection(
     :adapter  => "mysql",
     :host     => "localhost",
     :username => "root",
     :password => "",
     :database => "mr",
     :pool => 5
)

module MR
  module DB
    
  end
end

require 'mr/db/tables'
require 'mr/db/importer'
require 'mr/db/img_importer'