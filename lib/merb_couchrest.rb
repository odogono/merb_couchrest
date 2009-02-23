# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_couchrest] = {}
  require File.join(File.dirname(__FILE__) / "merb" / "orms" / "couchrest" / "connection" )
  
  
  class Merb::Orms::CouchRest::Connect < Merb::BootLoader
    after BeforeAppLoads
  
    def self.run

      Merb::Orms::CouchRest.connect
      
      Merb.logger.verbose! "Checking if we need to use CouchRest sessions"
      
      if Merb::Config.session_stores.include?(:couchrest)
        Merb.logger.debug "Using CouchRest sessions"
        require File.join(File.dirname(__FILE__) / "merb" / "session" / "couchrest_session")
      end
      
    end
    
  end

  
  Merb::Plugins.add_rakefiles "merb_couchrest/merbtasks"
  
end