class ApplicationDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.try(:to_i)
  end

  def updated_at
    object.updated_at.try(:to_i)
  end
end
