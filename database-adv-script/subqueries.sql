EXPLAIN ANALYZE
SELECT *
FROM (
    SELECT properties.property_id,
      AVG(reviews.rating) as property_rating
    FROM properties
      INNER JOIN reviews ON properties.property_id = reviews.property_id
    GROUP BY properties.property_id
  ) as avg_ratings_table
WHERE property_rating > 4.0;
WITH customers_with_bookings AS (
  SELECT users.user_id,
    COUNT(bookings.booking_id) as bookings_count
  FROM users
    INNER JOIN bookings ON users.user_id = bookings.user_id
  GROUP BY users.user_id
)
SELECT *
FROM customers_with_bookings
WHERE customers_with_bookings.bookings_count > 3;