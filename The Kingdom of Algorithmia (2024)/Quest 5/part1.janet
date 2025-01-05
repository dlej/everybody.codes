(use spork)

(def dancers
  (math/trans
    (map |(map scan-number (string/split " " $))
         (string/split "\n" (slurp "part1.in")))))

(defn do-dancer [dancers i]
  (let [clapper (-> dancers i 0)
        next-i (% (inc i) (length dancers))
        next-len (length (dancers next-i))
        j (if (>= next-len clapper)
            (dec clapper)
            (- (* 2 next-len) (dec clapper)))]
    (array/remove (dancers i) 0)
    (array/insert (dancers next-i) j clapper)))

(defn shout [dancers]
  (string/join (map |(string/format "%d" ($ 0)) dancers)))

(loop [i :range [0 10]
       :let [k (% i (length dancers))]]
  (do-dancer dancers k))

(print (shout dancers))
