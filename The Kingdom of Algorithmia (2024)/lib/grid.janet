(use spork)

(def DIRS [:up :right :down :left])
(def DIRS-8 [:up :up-right :right :down-right :down :down-left :left :up-left])

(defn forward [dir r c]
  (case dir
    :up [(- r 1) c]
    :up-right [(- r 1) (+ c 1)]
    :right [r (+ c 1)]
    :down-right [(+ r 1) (+ c 1)]
    :down [(+ r 1) c]
    :down-left [(+ r 1) (- c 1)]
    :left [r (- c 1)]
    :up-left [(- r 1) (- c 1)]))

(defn is-valid? [grid r c]
  (def [rows cols] (math/size grid))
  (and (>= r 0) (>= c 0) (< r rows) (< c cols)))

(defn neighbors [grid r c &opt diag]
  (def dirs (if diag DIRS-8 DIRS))
  (seq [dir :in dirs
        :let [step (forward dir r c)]
        :when (is-valid? grid ;step)]
    step))

(defn each [grid])

(defn pp [grid &opt fun]
  (def [rows cols] (math/size grid))
  (def fun (if fun fun identity))
  (for r 0 rows
    (for c 0 cols
      (prin (fun (-> grid r c))))
    (print)))
