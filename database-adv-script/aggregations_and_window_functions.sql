SELECT user_id,
  COUNT(bookings.booking_id) as bookings_count
FROM users
  INNER JOIN bookings ON users.user_id = bookings.user_id
GROUP BY users.user_id;
EXPLAIN ANALYZE WITH properties_bookings AS(
  SELECT properties.property_id,
    COUNT(bookings.booking_id) as bookings_count
  FROM properties
    INNER JOIN bookings ON properties.property_id = bookings.property_id
  GROUP BY property_id
)
SELECT *,
  RANK() OVER (
    ORDER BY bookings_count DESC
  ) AS bookings_rank
FROM properties_bookings;
-- ROW_NUMBER()