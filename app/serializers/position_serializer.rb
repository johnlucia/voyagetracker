class PositionSerializer < ActiveModel::Serializer
  attributes :p, :t 

  def p
    {lat: object.latitude.to_f, lng: object.longitude.to_f}
  end

  def t
    object.created_at.to_i
  end
end
