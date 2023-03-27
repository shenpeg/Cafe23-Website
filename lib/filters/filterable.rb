module Filterable
  include Actionable

  def boolean_filter(objects, filtering_params)
    filtering_params.each do |t_scope, f_scope|
      if(params[t_scope].present?)
        objects = true?(params[t_scope]) ? objects.public_send(t_scope) : objects.public_send(f_scope)
      end
    end
    objects
  end

  def param_filter(objects, filtering_params)
    filtering_params.each do |scope|
      objects = objects.public_send(scope, params[scope]) if params[scope].present?
    end
    objects
  end

end