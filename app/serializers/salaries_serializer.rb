class RoadTripSerializer
  include JSONAPI::Serializer
  attributes :destination, :forecast, :salaries
end