;;;Fungsi nanya pertanyaan + validasi jawaban
(deffunction ask-question (?qBEG ?qMID ?qEND $?allowed-values)
	(printout t ?qBEG ?qMID ?qEND)
	(bind ?answer (read))
	(if (numberp ?answer)
		then (bind ?answer ?answer)
	)
	(while (not (numberp ?answer)) do
		(printout t ?qBEG ?qMID ?qEND)
		(bind ?answer (read))
		(if (numberp ?answer)
			then (bind ?answer ?answer))
	)
?answer)

;;; Start, tanya value mean concave point -> worst perimeter, worst radius
(defrule Get-Value-mcp
	?x <- (initial-fact)
	=>
	(retract ?x)
	(bind ?mcp (ask-question "Mean concave points? " "" "" ))
	(assert (mean-concave-points ?mcp))
	(if (> ?mcp 0.05)
		then (assert (check-worst-perimeter 1))
	else (if (<= ?mcp 0.05)
		    then (assert (check-worst-radius 1))
		 )
	)
)

;;; Tanya value worst perimeter -> worst texture 1
(defrule Get-Value-worst-perimeter
	?x <- (check-worst-perimeter 1)
	=>
	(retract ?x)
	(bind ?wp (ask-question "Worst perimeter? " "" "" ))
	(assert (worst-perimeter ?wp))
	(if (> ?wp 114.45)
		then (assert (breast-cancer 0))
	else (if (<= ?wp 114.45)
		    then (assert (check-worst-texture-1 1))
		 )
	)
)

;;; Tanya value worst texture -> perimeter error, worst concave points
(defrule Get-Value-worst-texture-1
	?x <- (check-worst-texture-1 1)
	=>
	(retract ?x)
	(bind ?wt (ask-question "Worst texture? " "" "" ))
	(assert (worst-texture ?wt))
	(if (> ?wt 25.65)
		then (assert (check-perimeter-error 1))
	else (if (<= ?wt 25.65)
		    then (assert (check-worst-concave-points 1))
		 )
	)
)

;;; Tanya value perimeter error -> mean radius 1
(defrule Get-Value-perimeter-error
	?x <- (check-perimeter-error 1)
	=>
	(retract ?x)
	(bind ?pe (ask-question "Perimeter error? " "" "" ))
	(assert (perimeter-error ?pe))
	(if (> ?pe 1.56)
		then (assert (breast-cancer 0))
	else (if (<= ?pe 1.56)
		    then (assert (check-mean-radius-1 1))
		 )
	)
)


;;; Tanya value mean radius 1
(defrule Get-Value-mean-radius-1
	?x <- (check-mean-radius-1 1)
	=>
	(retract ?x)
	(bind ?mr (ask-question "Mean radius? " "" "" ))
	(assert (mean-radius ?mr))
	(if (> ?mr 13.34)
		then (assert (breast-cancer 1))
	else (if (<= ?mr 13.34)
		    then (assert (breast-cancer 0))
		 )
	)
)

;;; Tanya value worst concave points
(defrule Get-Value-worst-concave-point
	?x <- (check-worst-concave-points 1)
	=>
	(retract ?x)
	(bind ?wcp (ask-question "Worst concave points? " "" "" ))
	(assert (worst-concave-points ?wcp))
	(if (> ?wcp 0.17)
		then (assert (breast-cancer 0))
	else (if (<= ?wcp 0.17)
		    then (assert (breast-cancer 1))
		 )
	)
)


;;; Tanya value worst radius -> radius error, mean texture 1
(defrule Get-Value-worst-radius
	?x <- (check-worst-radius 1)
	=>
	(retract ?x)
	(bind ?wr (ask-question "Worst radius? " "" "" ))
	(assert (worst-radius ?wr))
	(if (> ?wr 16.83)
		then (assert (check-mean-texture-1 1))
	else (if (<= ?wr 16.83)
		    then (assert (check-radius-error 1))
		 )
	)
)

;;; Tanya value mean texture 1 -> concave points error
(defrule Get-Value-mean-texture-1
	?x <- (check-mean-texture-1 1)
	=>
	(retract ?x)
	(bind ?mt (ask-question "Mean texture? " "" "" ))
	(assert (worst-radius ?mt))
	(if (> ?mt 16.19)
		then (assert (check-concave-points-error 1))
	else (if (<= ?mt 16.19)
		    then (assert (breast-cancer 1))
		 )
	)
)

;;; Tanya value concave points error
(defrule Get-Value-concave-points-error
	?x <- (check-concave-points-error 1)
	=>
	(retract ?x)
	(bind ?cpe (ask-question "Concave points error? " "" "" ))
	(assert (concave-points-error ?cpe))
	(if (> ?cpe 0.01)
		then (assert (breast-cancer 1))
	else (if (<= ?cpe 0.01)
		    then (assert (breast-cancer 0))
		 )
	)
)

;;; Conclusion
(defrule Check-Breast-Cancer
	(breast-cancer ?bc)
	=>
	(if (eq ?bc 1)
		then (printout t "* Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
	else (if (eq ?bc 0)
			then (printout t "* Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf)
		)
	)
)

;;; mean concave points
;;; worst perimeter
;;; worst texture 1
;;; worst concave points
;;; perimeter error
;;; mean radius 1
;;; worst radius
;;; radius error
;;; mean texture 1
;;; concave points error
;;; mean smoothness
;;; worst texture 2
;;; worst area
;;; mean radius 2
;;; mean texture 2

;;; mean concave points -> worst perimeter, worst radius
;;; worst perimeter -> worst texture 1
;;; worst texture 1 -> perimeter error, worst concave points
;;; perimeter error -> mean radius 1
;;; worst radius -> radius error, mean texture 1
;;; radius error -> worst texture 2, mean smoothness
;;; mean texture 1 -> concave points error
;;; worst texture 2 -> worst area
;;; worst area -> mean radius 2
;;; mean radius 2 -> mean texture 2