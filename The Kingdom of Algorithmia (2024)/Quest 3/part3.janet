(use spork)
(import ../lib/grid)

(def notes-peg
  '{:row (group (any (<- (if-not "\n" 1))))
    :matrix (group (* :row (any (* "\n" :row))))
    :main :matrix})

(def [grid] (peg/match notes-peg (slurp "part3.in")))
(def grid (map |(map |(if (= "#" $) 1 0) $) grid))

(defn dig-once [grid depth]
  (def [rows cols] (math/size grid))
  (def previous-depth (- depth 1))
  (defn check-previous-depth [r c] (>= (-> grid r c) previous-depth))
  (var digs 0)
  (loop [r :range [0 rows]
         c :range [0 cols]]
    (def neighbors (grid/neighbors grid r c true))
    (when (= 9 (sum (map |(if (check-previous-depth ;$) 1 0) [[r c] ;neighbors])))
      (put (grid r) c depth)
      (set digs (inc digs))))
  digs)

# (grid/pp grid |(if (> $ 0) $ "."))
(var digs (sum (flatten grid)))
(var depth 2)
(forever
  # (printf "Depth: %d" depth)
  (def new-digs (dig-once grid depth))
  (when (= new-digs 0) (break))
  (set digs (+ digs new-digs))
  (set depth (inc depth))
  # (grid/pp grid |(if (> $ 0) $ "."))
)

(pp digs)
