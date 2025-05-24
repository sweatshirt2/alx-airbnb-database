## Before Indexing

```
| -> Table scan on avg_ratings_table  (cost=2.5..2.5 rows=0) (actual time=1..1 rows=1 loops=1)
    -> Materialize  (cost=0..0 rows=0) (actual time=1..1 rows=1 loops=1)
        -> Filter: (property_rating > 4.0)  (actual time=0.0668..0.0677 rows=1 loops=1)
            -> Table scan on <temporary>  (actual time=0.0636..0.064 rows=2 loops=1)
                -> Aggregate using temporary table  (actual time=0.0625..0.0625 rows=2 loops=1)
                    -> Filter: (reviews.property_id = properties.property_id)  (cost=1.1 rows=2) (actual time=0.0447..0.048 rows=2 loops=1)
                        -> Inner hash join (<hash>(reviews.property_id)=<hash>(properties.property_id))  (cost=1.1 rows=2) (actual time=0.0427..0.0452 rows=2 loops=1)
                            -> Table scan on reviews  (cost=0.176 rows=2) (actual time=0.00679..0.00826 rows=2 loops=1)
                            -> Hash
                                -> Covering index scan on properties using host_id  (cost=0.45 rows=2) (actual time=0.0183..0.0215 rows=2 loops=1)
```

## After Indexing

```
| -> Table scan on avg_ratings_table  (cost=3.27..4 rows=1.41) (actual time=0.11..0.11 rows=1 loops=1)
    -> Materialize  (cost=1.49..1.49 rows=1.41) (actual time=0.108..0.108 rows=1 loops=1)
        -> Filter: (avg(reviews.rating) > 4.0)  (cost=1.35 rows=1.41) (actual time=0.0767..0.0833 rows=1 loops=1)
            -> Group aggregate: avg(reviews.rating)  (cost=1.35 rows=1.41) (actual time=0.0724..0.0779 rows=2 loops=1)
                -> Nested loop inner join  (cost=1.15 rows=2) (actual time=0.0534..0.0693 rows=2 loops=1)
                    -> Covering index scan on properties using PRIMARY  (cost=0.45 rows=2) (actual time=0.0254..0.0279 rows=2 loops=1)
                    -> Covering index lookup on reviews using idx_rating (property_id=properties.property_id)  (cost=0.3 rows=1) (actual time=0.0165..0.0194 rows=1 loops=2)
```