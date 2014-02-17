require "./ns_observers"
Dir["./observers/*.rb"].each { |file| require file }

OBSERVERS_CONF = 'observers.yml'
observers = NSObservers.new(OBSERVERS_CONF)
observers.notify("home", "breakfast")

observers.notify_all
