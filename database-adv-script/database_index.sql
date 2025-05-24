CREATE INDEX idx_rating ON reviews (property_id, rating);
CREATE INDEX idx_rating_property_id ON reviews (property_id);
CREATE INDEX idx_review_rating ON reviews (rating);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
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