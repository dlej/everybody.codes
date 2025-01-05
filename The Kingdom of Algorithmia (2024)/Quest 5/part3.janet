(use spork)

(def dancers
  (math/trans
    (map |(map scan-number (string/split " " $))
         (string/split "\n" (slurp "part3.in")))))

(defn do-dancer [dancers i]
  (let [clapper (-> dancers i 0)
        next-i (% (inc i) (length dancers))
        clapper-mod (% clapper (* 2 (length (dancers next-i))))
        next-len (length (dancers next-i))
        j (cond (= 0 clapper-mod) 1
            (>= next-len clapper-mod) (dec clapper-mod)
            (- (* 2 next-len) (dec clapper-mod)))]
    (array/remove (dancers i) 0)
    (array/insert (dancers next-i) j clapper)))

(defn get-shout [dancers]
  (string/join (map |(string/format "%d" ($ 0)) dancers)))

(def shouts @{})
(def reprs @{})

(loop [i :range [1 1000000]
       :let [k (% (dec i) (length dancers))]]
  (do-dancer dancers k)
  (def shout (get-shout dancers))
  (put shouts shout true)
  (def repr (freeze dancers))
  (when (= 0 (% i 100000))
    (pp i))
  (if (reprs repr)
    (do
      (pp (max ;(map |(scan-number $) (keys shouts))))
      (break))
    (put reprs repr true)))
