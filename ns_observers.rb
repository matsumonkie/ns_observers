class NSObservers

  require "yaml"
  
  #--------------------------------------------------------------------------------  
  def initialize(yaml_conf)
    @observers = YAML::load_file(yaml_conf)
    check_valid_classes_from_conf if @observers
  end

  #--------------------------------------------------------------------------------
  def notify(namespace, action, opts = {})
    if namespace && action
      observers_for(namespace, action).each do |observer|
        observer = Object.const_get(observer.to_s).new
        observer.call(opts)
      end
    end
  end

  #--------------------------------------------------------------------------------
  def notify_all(opts = {})
    all_classes.each do |klass|
      observer = Object.const_get(klass).new
      observer.call(opts)
    end
  end

  private

  #--------------------------------------------------------------------------------
  def all_classes
    klasses = @observers.values.map { |actionToClasses| actionToClasses.values }
    klasses.flatten
  end

  #--------------------------------------------------------------------------------
  def check_valid_classes_from_conf
    all_classes.each do |klass|
      # raise an exception if class not valid
      Object.const_get(klass)
    end    
  end
 
  #--------------------------------------------------------------------------------
  def observers_for(namespace, action)
    @observers.fetch(namespace, {}).fetch(action, [])
  end
end
