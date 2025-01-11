(def notes-peg
  '{:node (<- (some (+ :w "@")))
    :branching (group (* :node ":" :node (any (* "," :node))))
    :main (* :branching (any (* "\n" :branching)))})

(def branches
  (struct ;(mapcat |(do [($ 0) (slice $ 1)])
                   (peg/match notes-peg (slurp "part1.in")))))

(defn fruit-paths [branches &opt paths]
  (def paths (if paths paths [["RR"]]))
  (mapcat
    |(cond (= ($ 0) "@") [$]
       (not (branches ($ 0))) []
       (fruit-paths branches (map (fn [head] [head ;$]) (branches ($ 0)))))
    paths))

(def by-length @{})
(each path (fruit-paths branches)
  (if-not (by-length (length path))
    (put by-length (length path) @[]))
  (array/push (by-length (length path)) path))

(each paths (values by-length)
  (when (= (length paths) 1)
    (print (string/join (reverse (paths 0))))))
