require 'java'

module GetBack
  module JoJo
    @@executors = java.util.Collections.synchronizedList([])

    at_exit { @@executors.each {|e| e.shutdown} }

    def get_back(method, config={}, &block)
      with_executor_service(config[:pool]) do |e|

        # give the new method a name
        gb_method_name = "_get_back_#{method}_".to_sym

        # create a new proxy
        old_method = instance_method(method)
        define_method(gb_method_name) do |*args|
          old_method.bind(self).call(*args)
        end

        # redefine the method
        define_method(method) do |*args|
          e.submit do
            begin
              r = send(gb_method_name, *args)
              if block_given?
                if block.arity == 1
                  yield self
                else
                  yield self, r
                end
              end
            rescue Exception => ex
              send(config[:rescue], ex) if config[:rescue]
              raise
            ensure
              send(config[:ensure]) if config[:ensure]
            end
          end
        end
      end
    end

    private

    def with_executor_service(pool_size=nil)
      if pool_size.nil? 
        e = java.util.concurrent.Executors.newCachedThreadPool
      else
        e = java.util.concurrent.Executors.newFixedThreadPool(pool_size.to_i)
      end
      @@executors << e
      yield e
    end
  end
end
