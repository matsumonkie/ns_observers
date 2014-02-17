ns_observers
============

ns_observers is a simple namespaced observers pattern. Instead of calling notify for every observer, ns_observers narrow down specific observers. 
Less talk more code:

    observers = NSObservers.new("some_config_file.yaml")
    observers.notify("some_namespace", "some_action", optional_hash_args)
    
Pretty simple isn't it ?

NSObservers will execute the call function of the concern observers.
Namespaces, actions and observers are configured in a yaml file.

For example :
    
    # my yaml config file
    home:                                                                        
      breakfast:
        - DrinkCoffee
        - EatBacon



    # drink_coffee.rb
    class DrinkCoffee
      def call(opts)                                                             
        puts "black coffee please !!!"
      end
    end


    # eat_bacon.rb
    class EatBacon
      def call(opts)                                                             
        puts "Bacooooooooon time !!!"
      end
    end


Now, calling:

    observers.notify("home", "breakfast")

Will produce:

    "black coffee please !!!!"
    "Bacooooooooo time !!!"
    
But you can still use it as a basic observer implementation with

    observers.notify_all()


