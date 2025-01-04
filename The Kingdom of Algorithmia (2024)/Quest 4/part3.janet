(use ../lib/utils)

(def nails (sort (map scan-number (string/split "\n" (slurp "part3.in")))))

(defn l1-distance [y xs]
  (sum (map |(math/abs (- y $)) xs)))

(def to_try (range (nails (dec (div (length nails) 2)))
                   (inc (nails (div (length nails) 2)))))
(pp (min ;(map |(l1-distance $ nails) to_try)))
