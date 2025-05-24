EXPLAIN
SELECT *
FROM bookings
  LEFT JOIN users ON bookings.user_id = users.user_id
  LEFT JOIN properties ON bookings.property_id = properties.property_id
  LEFT JOIN payments ON bookings.booking_id = payments.booking_id
WHERE bookings.start_date = '2025-06-01'
  AND payments.amount > 1000.00;