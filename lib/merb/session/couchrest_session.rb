require 'couchrest'
require 'merb-core/dispatch/session'


module Merb
  
  class CouchRestSessionStore  < CouchRest::ExtendedDocument
    
    class << self
      
      # ==== Parameters
      # session_id<String>:: ID of the session to retrieve.
      #
      # ==== Returns
      # ContainerSession:: The session corresponding to the ID.
      def retrieve_session(session_id)

        begin
          doc = get( session_id )
          return Marshal.load(doc[:data])
        rescue
        end
        
      end
    
      # ==== Parameters
      # session_id<String>:: ID of the session to set.
      # data<ContainerSession>:: The session to set.
      # 
      # :api: private
      def store_session(session_id, data)
        
        marshaled = Marshal.dump(data)
        
        begin
          doc = get( session_id )
          doc[:data] = marshaled
          doc[:updated_at] = Time.now
          doc.save
        rescue
          doc = self.new( '_id' => session_id, :data => marshaled, :created_at => Time.now )
          doc.save
        end
      
      end
    
      # ==== Parameters
      # session_id<String>:: ID of the session to delete.
      #
      # :api: private
      def delete_session(session_id)
        begin
          doc = get(session_id) 
          doc.destroy()
        rescue
        end
      end
    
    end
    
  end
  
  
  class CouchdbSession < SessionStoreContainer
    
    # The session store type
    self.session_store_type = :couchrest
    
    # The store object is the model class itself
    self.store = CouchRestSessionStore
    
  end
  
  
end

