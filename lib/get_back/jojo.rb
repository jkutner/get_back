require 'java'

module GetBack
  module JoJo 
    def included(base)
      #base.extend(ClassMethods)
    end
  
	  
	  def get_back(method, config={})
	    # create thread pool
	    e = java.util.concurrent.Executors.newCachedThreadPool
		  
	    #options
	    #  - pool_size(int)
	    #  - concurrency(int)
	    #  - on_error => :method/lambda
	    #  - on_success => :method/lambda
		  
		# give the new method a name
		gb_method_name = "_get_back_#{method}_".to_sym
		
		# create a new proxy
		old_method = instance_method(method)		
	    define_method(gb_method_name) do
	      old_method.bind(self).call
	    end
	    
	    # redefine the method
	    define_method(method) do
	      e.submit do
	        begin
  	          send(gb_method_name)
  	          # todo invoke on_success
  	        rescue
  	          # todo invoke on_error
  	        end
  	      end
	    end
	  end 
	  	  
	module ClassMethods
	  def get_back
	    # create the proxy
	  end
	end
	
	module Proxy
	
	end
  end
end
