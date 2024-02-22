class RedisTimestampSerializer
  include JSONAPI::Serializer
  attributes :time1,
             :time2,
             :time3,
             :time4
end
