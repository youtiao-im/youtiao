class ApplicationDecorator < Draper::Decorator
  delegate_all

  def id
    object.to_param
  end

  def type
    object.class.name
  end
end
