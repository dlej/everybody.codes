(use spork)

(def dancers
  (math/trans
    (map |(map scan-number (string/split " " $))
         (string/split "\n" (slurp "part2.in")))))

(defn do-dancer [dancers i]
  (let [clapper (-> dancers i 0)
        next-i (% (inc i) (length dancers))
        clapper-mod (% clapper (* 2 (length (dancers next-i))))
        next-len (length (dancers next-i))
        j (if (>= next-len clapper-mod)
            (dec clapper-mod)
            (- (* 2 next-len) (dec clapper-mod)))]
    (array/remove (dancers i) 0)
    (array/insert (dancers next-i) j clapper)))

(defn get-shout [dancers]
  (string/join (map |(string/format "%d" ($ 0)) dancers)))

(defn dancers-str [dancers]
  (string/join (map |(string/join (map |(string/format "%d" $) $)) dancers) "|"))

(def shout-rounds @{})

(loop [i :range [1 10000000]
       :let [k (% (dec i) (length dancers))]]
  (do-dancer dancers k)
  (def shout (get-shout dancers))
  (put shout-rounds shout (inc (get shout-rounds shout 0)))
  (when (= 2024 (shout-rounds shout))
    (print (* i (scan-number shout)))
    (break)))
