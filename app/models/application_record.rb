class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def method_missing(m, *args, &block)
    decorator = ("GraphqlDecorators::" + self.class.name.demodulize + "Decorator").constantize.new(self) 
    if decorator.respond_to?(m, *args, &block)
      decorator.send(m, *args, &block)
    else
      super
    end
  end
  
end
