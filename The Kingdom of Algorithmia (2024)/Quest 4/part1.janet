(def nails (map scan-number (string/split "\n" (slurp "part1.in"))))

(pp (- (sum nails) (* (length nails) (min ;nails))))
