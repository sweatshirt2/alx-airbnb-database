SELECT *
FROM bookings
  INNER JOIN users ON bookings.user_id = users.user_id;
SELECT *
FROM properties
  LEFT JOIN reviews ON properties.property_id = reviews.property_id
ORDER BY bookings.start_date;
-- SELECT *
-- FROM bookings
--   FULL OUTER JOIN users ON bookings.user_id = users.user_id;
SELECT *
FROM bookings
  LEFT JOIN users ON bookings.user_id = users.user_id
UNION
SELECT *
FROM bookings
  RIGHT JOIN users ON bookings.user_id = users.user_id
ORDER BY bookings.start_date;