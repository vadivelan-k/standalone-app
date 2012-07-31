class AggregateCallbacks
  def initialize(attr_to_sum, parent, parent_attr, parent_class)
    @attr = attr_to_sum
    @attr_was = "#{attr_to_sum}_was"
    @parent = parent
    @parent_id_was = "#{parent}_id_was"
    @parent_id_changed = "#{parent}_id_changed?"
    @parent_attr = parent_attr
    @parent_attr_setter = "#{parent_attr}="
    @parent_class = parent_class
  end
  
  def after_create(model)
    unless (parent = model.send(@parent)).nil?
      parent.send(@parent_attr_setter, parent.send(@parent_attr) + model.send(@attr))
      parent.save! if parent.changed?
    end
  end
  
  def after_update(model)
    old_id = model.send(@parent_id_was)
    unless old_id.nil?
      if model.send(@parent_id_changed)
        old = @parent_class.find_by_id(old_id)
        unless old.nil?
          old.send(@parent_attr_setter, old.send(@parent_attr) - model.send(@attr_was))
          old.save!
        end
      else
        parent = model.send(@parent)
        parent.send(@parent_attr_setter,  parent.send(@parent_attr) - model.send(@attr_was))
      end
    end
    unless (parent = model.send(@parent)).nil?
      parent.send(@parent_attr_setter, parent.send(@parent_attr) + model.send(@attr))
      parent.save! if parent.changed?
    end
  end
  
  def after_destroy(model)
    old_id = model.send(@parent_id_was)
    unless old_id.nil?
      old = @parent_class.find_by_id(old_id)
      unless old.nil?
        old.send(@parent_attr_setter, old.send(@parent_attr) - model.send(@attr_was))
        old.save!
      end
    end
  end
end