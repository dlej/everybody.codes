(def notes-peg
  ~{:word (<- (some :w))
    :words (* "WORDS:" (group (* :word (any (* "," :word)))))
    :inscription (<- (any 1))
    :main (* :words (any :s) :inscription)})

(def [words inscription] (peg/match notes-peg (slurp "part1.in")))
(pp (sum (map (fn [word]
                (def word-peg ~{:main ,word})
                (length (peg/find-all word-peg inscription)))
              words)))
