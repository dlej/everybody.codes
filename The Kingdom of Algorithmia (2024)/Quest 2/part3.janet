(use spork)
(use ../lib/utils)

(def notes-peg
  '{:word (<- (some :w))
    :words (* "WORDS:" (group (* :word (any (* "," :word)))))
    :row (group (any (<- (if-not "\n" 1))))
    :matrix (group (* :row (any (* "\n" :row))))
    :main (* :words (any :s) :matrix)})

(def [words armor] (peg/match notes-peg (slurp "part3.in")))
(array/concat words (map string/reverse words))

(defn find-all-horizontal-runes [inscription]
  (def [nrows ncols] (math/size inscription))
  (def ind (math/zero ncols nrows))
  (each word words
    (def word-peg ~{:main ,word})
    (loop [[i row] :pairs inscription]
      (each j (peg/find-all word-peg (string/join row))
        (for k j (+ j (length word))
          (put (ind i) k 1)))))
  ind)

(defn find-all-horizontal-runes-wrapped [inscription]
  (def [nrows ncols] (math/size inscription))
  (def inscription-wrap (math/join-cols inscription inscription))
  (def ind-wrap (find-all-horizontal-runes inscription-wrap))
  (binary-threshold
    (math/add (math/slice-m ind-wrap [0 nrows] [0 ncols])
              (math/slice-m ind-wrap [0 nrows] [ncols (* 2 ncols)]))))

(defn find-all-runes [inscription]
  (binary-threshold
    (math/add (find-all-horizontal-runes-wrapped inscription)
              (math/trans (find-all-horizontal-runes (math/trans inscription))))))

(pp (sum (flatten (find-all-runes armor))))
