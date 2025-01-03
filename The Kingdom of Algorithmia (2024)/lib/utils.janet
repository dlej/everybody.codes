(defn binary-threshold [m]
  (map |(map |(if (> $ 0) 1 0) $) m))

(defn string/explode [s] (map string/from-bytes s))
