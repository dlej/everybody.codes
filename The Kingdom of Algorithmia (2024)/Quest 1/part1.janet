(def creatures-list
  '{:main (some (<- (range "AC")))})

(def creatures (peg/match creatures-list (slurp "part1.in")))
(defn potion-map [creature]
  (case creature
    "A" 0
    "B" 1
    "C" 3))

(printf "%d" (sum (map potion-map creatures)))
