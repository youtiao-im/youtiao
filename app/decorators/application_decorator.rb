class ApplicationDecorator < Draper::Decorator
  def id
    object.to_param
  end

  def created_at
    object.created_at.try(:to_i)
  end

  def updated_at
    object.updated_at.try(:to_i)
  end
end
