(def notes-peg
  ~{:word (<- (some :w))
    :words (* "WORDS:" (group (* :word (any (* "," :word)))))
    :inscription (<- (any 1))
    :main (* :words (any :s) :inscription)})

(def [words inscription] (peg/match notes-peg (slurp "part2.in")))
(array/concat words (map string/reverse words))
(def rune-char-ind (map (fn [&] 0) (string/bytes inscription)))
(each word words
  (def word-peg ~{:main ,word})
  (each i (peg/find-all word-peg inscription)
    (for j i (+ i (length word))
      (put rune-char-ind j 1))))
(pp (sum rune-char-ind))
