class NSObservers

  require "yaml"
  
  #--------------------------------------------------------------------------------  
  def initialize(yaml_conf)
    @observers = YAML::load_file(yaml_conf)
    if @observers
      check_valid_classes_from_conf(@observers)
    end
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
    conf.each_value do |actionToClasses|
      actionToClasses.each_value do |classes|
        classes.each do |klass|
          observer = Object.const_get(observer.to_s).new
          observer.call(opts)
        end
      end
    end
  end

  private

  #--------------------------------------------------------------------------------
  def check_valid_classes_from_conf(conf)
    conf.each_value do |actionToClasses|
      actionToClasses.each_value do |klasses|
        klasses.each do |klass|
          # raise an exception if class not valid
          Object.const_get(klass)
        end
      end
    end
  end
 
  #--------------------------------------------------------------------------------
  def observers_for(namespace, action)
    @observers.fetch(namespace, {}).fetch(action, [])
  end
end
