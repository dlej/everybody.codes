(def nails (map scan-number (string/split "\n" (slurp "part2.in"))))

(pp (- (sum nails) (* (length nails) (min ;nails))))
