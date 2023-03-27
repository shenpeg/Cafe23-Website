module Actionable
  extend ActiveSupport::Concern

  def true?(b)
    ActiveModel::Type::Boolean.new.cast(b)
  end

end