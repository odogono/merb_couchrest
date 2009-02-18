# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_couchrest] = {}
  require File.join(File.dirname(__FILE__) / "merb" / "orms" / "couchrest" / "connection" )
  
  Merb::BootLoader.before_app_loads do
    
    Merb::Orms::CouchRest.connect
    
    if Merb::Config.session_stores.include?(:couchrest)
      Merb.logger.debug "Using CouchRest sessions"
      require File.join(File.dirname(__FILE__) / "merb" / "session" / "couchrest_session")
    end
    
  end
  
  Merb::BootLoader.after_app_loads do
    
    # TODO - How do we disconnect if, in fact, we need to ?
    
  end
  
  Merb::Plugins.add_rakefiles "merb_couchrest/merbtasks"
  
end