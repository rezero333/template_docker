$redis_local = Redis.new(
  host: "190.20.200.22",
  port: "6385",
  driver: :hiredis,
  db: "1"
)