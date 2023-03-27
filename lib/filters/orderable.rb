module Orderable
  include Actionable

  def order(objects, ordering_params)
    ordering_params.each do |scope|
      if params[scope].present? && true?(params[scope])
        objects = objects.public_send(scope)
      end
    end
    objects
  end

end