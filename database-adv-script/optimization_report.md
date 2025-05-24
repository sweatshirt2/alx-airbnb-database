### Before
```
+----+-------------+------------+------------+--------+---------------------+---------+---------+--------------------------+------+----------+--------------------------------------------+
| id | select_type | table      | partitions | type   | possible_keys       | key     | key_len | ref                      | rows | filtered | Extra                                      |
+----+-------------+------------+------------+--------+---------------------+---------+---------+--------------------------+------+----------+--------------------------------------------+
|  1 | SIMPLE      | properties | NULL       | ALL    | PRIMARY             | NULL    | NULL    | NULL                     |    2 |   100.00 | NULL                                       |
|  1 | SIMPLE      | bookings   | NULL       | ALL    | PRIMARY,property_id | NULL    | NULL    | NULL                     |    2 |    50.00 | Using where; Using join buffer (hash join) |
|  1 | SIMPLE      | users      | NULL       | eq_ref | PRIMARY             | PRIMARY | 1022    | air_bnb.bookings.user_id |    1 |   100.00 | NULL                                       |
|  1 | SIMPLE      | payments   | NULL       | ALL    | booking_id          | NULL    | NULL    | NULL                     |    6 |    50.00 | Using where; Using join buffer (hash join) |
+----+-------------+------------+------------+--------+---------------------+---------+---------+--------------------------+------+----------+--------------------------------------------+
4 rows in set, 1 warning (0.00 sec)
```

### After
```
+----+-------------+------------+------------+--------+-----------------------------------------------+---------+---------+--------------------------+------+----------+--------------------------------------------+
| id | select_type | table      | partitions | type   | possible_keys                                 | key     | key_len | ref                      | rows | filtered | Extra                                      |
+----+-------------+------------+------------+--------+-----------------------------------------------+---------+---------+--------------------------+------+----------+--------------------------------------------+
|  1 | SIMPLE      | properties | NULL       | ALL    | PRIMARY                                       | NULL    | NULL    | NULL                     |    2 |   100.00 | NULL                                       |
|  1 | SIMPLE      | bookings   | NULL       | ALL    | idx_bookings_user_id,idx_bookings_property_id | NULL    | NULL    | NULL                     |    2 |    50.00 | Using where; Using join buffer (hash join) |
|  1 | SIMPLE      | users      | NULL       | eq_ref | PRIMARY                                       | PRIMARY | 1022    | air_bnb.bookings.user_id |    1 |   100.00 | NULL                                       |
|  1 | SIMPLE      | payments   | NULL       | ALL    | idx_payments_booking_id                       | NULL    | NULL    | NULL                     |    6 |   100.00 | Using where; Using join buffer (hash join) |
+----+-------------+------------+------------+--------+-----------------------------------------------+---------+---------+--------------------------+------+----------+--------------------------------------------+
4 rows in set, 1 warning (0.00 sec)
```