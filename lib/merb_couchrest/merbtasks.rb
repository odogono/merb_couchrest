namespace :couchrest do

  
  task :merb_start do
    Merb.start :adapter => 'runner',
               :environment => ENV['MERB_ENV'] || 'development'
  end
  
  namespace :sessions do
    
    desc "Clears sessions"
    task :clear => :merb_start do
      
      Merb::CouchRestSessionStore.all.each{ |doc| doc.database.delete_doc(doc,true) }
      Merb::CouchRestSessionStore.bulk_save()
      
    end
    
  end
  
  
  
end