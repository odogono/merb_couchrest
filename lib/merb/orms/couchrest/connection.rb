require "fileutils"
require "couchrest"


module Merb
  module Orms
    module CouchRest
      
      
      class << self
        
        def config_file() Merb.dir_for(:config) / "database.yml" end
        def sample_dest() Merb.dir_for(:config) / "database.yml.sample" end
        def sample_source() File.dirname(__FILE__) / "database.yml.sample" end
      
        def copy_sample_config
          FileUtils.cp sample_source, sample_dest unless File.exists?(sample_dest)
        end
        
        
        def config
          @config ||= begin
            # Convert string keys to symbols
            full_config = Erubis.load_yaml_file(config_file)
            config = (Merb::Plugins.config[:merb_couchrest] = {})
            (full_config[Merb.environment.to_sym] || full_config[Merb.environment] || full_config[:development]).each do |key, value|
              config[key.to_sym] = value
            end
            config
          end
        end
        
        def connect
          if File.exists?(config_file)
            
            # it is possible that we have been passed an array of hosts - attempt each in turn until one is found
            
            config[:host].each do |host|
              
              begin
                
                Merb.logger.info!("Attempting connection to the '#{config[:database]}' database on '#{host}' ...")
                
                # Merb.logger.info!("using string #{host}/#{config[:database]}")
                
                server = ::CouchRest.new(host)
                
                # calling this will cause an exception if the host is invalid
                info = server.info()
                
                Merb.logger.info!("Connected to '#{host}' - version #{info['version']}")
                
                begin
                  if config[:create_db_if_absent]
                    database_connection = server.database!( config[:database] )
                  else
                    database_connection = server.database( config[:database] )
                  end
                
                  # this will test the connection and raise a ResourceNotFound exception
                  # if it is not valid
                  database_connection.info()
                
                  # set the default database
                  ::CouchRest::Document.use_database( database_connection )

                  # we are done - return with the result
                  return database_connection
                  
                rescue  RestClient::ResourceNotFound
                  Merb.logger.info!("#{config[:database]} is not available on #{host}")
                end
                
              rescue Errno::ECONNREFUSED
                Merb.logger.info!("#{host} not available")
              rescue => e
                Merb.logger.info!("Connection Error: #{e}")
                Merb.print_colorized_backtrace(e)
                exit(1)
              end
              
            end
            
            # if we have reached this point, then a connection wasn't found
            
            Merb.logger.info!("Unable to connect")
            exit(1)
            
            
          else
            copy_sample_config
            Merb.logger.set_log(STDERR)
            Merb.logger.error! "No database.yml file found at #{config_file}."
            Merb.logger.error! "A sample file was created called #{sample_dest} for you to copy and edit."
            exit(1)
          end  
        end        

        
        
      end

    end
  end
end