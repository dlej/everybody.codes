(use ../lib/utils)

(def battle-list
  '{:creature (set "ABCDx")
    :battle (* :creature :creature :creature)
    :main (some (<- :battle))})

(def battles (peg/match battle-list (slurp "part3.in")))

(defn potion-map [creature]
  (case creature
    "x" 0
    "A" 0
    "B" 1
    "C" 3
    "D" 5))
(defn battle-cost [battle]
  (var x 0)
  (def s (sum (map (fn [creature]
                     (if (= creature "x") (set x (inc x)))
                     (potion-map creature))
                   (string/explode battle))))
  (+ s (* (- 2 x) (- 3 x))))

(printf "%d" (sum (map battle-cost battles)))
