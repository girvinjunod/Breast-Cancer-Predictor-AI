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

)

;;; Tanya value worst perimeter -> worst texture 1
(defrule Get-Value-worst-perimeter
	(mean-concave-points ?mcp)
	(test (> ?mcp 0.05))
	=>
	(bind ?wp (ask-question "Worst perimeter? " "" "" ))
	(assert (worst-perimeter ?wp))
	(if (> ?wp 114.45)
		then (assert (breast-cancer 0))
	)
)

;;; Tanya value worst texture -> perimeter error, worst concave points
(defrule Get-Value-worst-texture-1
	(mean-concave-points ?mcp)
	(test (> ?mcp 0.05))
	(worst-perimeter ?wp)
	(test (<= ?wp 114.45))
	=>
	(bind ?wt (ask-question "Worst texture? " "" "" ))
	(assert (worst-texture ?wt))
)

;;; Tanya value perimeter error -> mean radius 1
(defrule Get-Value-perimeter-error
	(mean-concave-points ?mcp)
	(test (> ?mcp 0.05))
	(worst-perimeter ?wp)
	(test (<= ?wp 114.45))
	(worst-texture ?wt)
	(test (> ?wt 25.65))
	=>
	(bind ?pe (ask-question "Perimeter error? " "" "" ))
	(assert (perimeter-error ?pe))
	(if (> ?pe 1.56)
		then (assert (breast-cancer 0))
	)
)


;;; Tanya value mean radius 1
(defrule Get-Value-mean-radius-1
	(mean-concave-points ?mcp)
	(test (> ?mcp 0.05))
	(worst-perimeter ?wp)
	(test (<= ?wp 114.45))
	(worst-texture ?wt)
	(test (> ?wt 25.65))
	(perimeter-error ?pe)
	(test (<= ?pe 1.56))
	=>
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
	(mean-concave-points ?mcp)
	(test (> ?mcp 0.05))
	(worst-perimeter ?wp)
	(test (<= ?wp 114.45))
	(worst-texture ?wt)
	(test (<= ?wt 25.65))
	=>
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
	(mean-concave-points ?mcp)
	(test (<= ?mcp 0.05))
	=>
	(bind ?wr (ask-question "Worst radius? " "" "" ))
	(assert (worst-radius ?wr))
)

;;; Tanya value mean texture 1 -> concave points error
(defrule Get-Value-mean-texture-1
	(mean-concave-points ?mcp)
	(test (<= ?mcp 0.05))
	(worst-radius ?wr)
	(test (> ?wr 16.83))
	=>
	(bind ?mt (ask-question "Mean texture? " "" "" ))
	(assert (mean-texture ?mt))
	(if (<= ?mt 16.19)
		    then (assert (breast-cancer 1))
	)
)

;;; Tanya value concave points error
(defrule Get-Value-concave-points-error
	(mean-concave-points ?mcp)
	(test (<= ?mcp 0.05))
	(worst-radius ?wr)
	(test (> ?wr 16.83))
	(mean-texture ?mt)
	(test (> ?mt 16.19))
	=>
	(bind ?cpe (ask-question "Concave points error? " "" "" ))
	(assert (concave-points-error ?cpe))
	(if (> ?cpe 0.01)
		then (assert (breast-cancer 1))
	else (if (<= ?cpe 0.01)
		    then (assert (breast-cancer 0))
		 )
	)
)

;;; Tanya value radius error -> worst texture, mean smoothness
(defrule Get-Value-radius-error
	(mean-concave-points ?mcp)
	(test (<= ?mcp 0.05))
	(worst-radius ?wr)
	(test (<= ?wr 16.83))
	=>
	(bind ?re (ask-question "Radius error? " "" "" ))
	(assert (radius-error ?re))
)

;;; Tanya value radius error -> worst texture, mean smoothness
(defrule Get-Value-worst-texture-2
	(mean-concave-points ?mcp)
	(test (<= ?mcp 0.05))
	(worst-radius ?wr)
	(test (<= ?wr 16.83))
	(radius-error ?re)
	(test (<= ?re 0.63))
	=>
	(bind ?wt (ask-question "Worst texture? " "" "" ))
	(assert (worst-texture ?wt))
	(if (<= ?wt 30.15)
		    then (assert (breast-cancer 1))
  )
)

;;; Tanya value worst area -> mean radius
(defrule Get-Value-worst-area
	(mean-concave-points ?mcp)
	(test (<= ?mcp 0.05))
	(worst-radius ?wr)
	(test (<= ?wr 16.83))
	(radius-error ?re)
	(test (<= ?re 0.63))
  (worst-texture ?wt)
  (test (> ?wt 30.15))
	=>
	(bind ?wa (ask-question "Worst area? " "" "" ))
	(assert (worst-area ?wa))
	(if (<= ?wa 641.60)
		    then (assert (breast-cancer 1))
  )
)

;;; Tanya value mean radius -> mean texture
(defrule Get-Value-mean-radius-2
	(mean-concave-points ?mcp)
	(test (<= ?mcp 0.05))
	(worst-radius ?wr)
	(test (<= ?wr 16.83))
	(radius-error ?re)
	(test (<= ?re 0.63))
  (worst-texture ?wt)
  (test (> ?wt 30.15))
  (worst-area ?wa)
  (test (> ?wa 641.60))
	=>
	(bind ?mr (ask-question "Mean radius? " "" "" ))
	(assert (mean-radius ?mr))
	(if (> ?mr 13.45)
		    then (assert (breast-cancer 1))
  )
)

;;; Tanya value mean texture
(defrule Get-Value-mean-texture-2
	(mean-concave-points ?mcp)
	(test (<= ?mcp 0.05))
	(worst-radius ?wr)
	(test (<= ?wr 16.83))
	(radius-error ?re)
	(test (<= ?re 0.63))
  (worst-texture ?wt)
  (test (> ?wt 30.15))
  (worst-area ?wa)
  (test (> ?wa 641.60))
  (mean-radius ?mr)
  (test (<= ?mr 13.45))
	=>
	(bind ?mt (ask-question "Mean texture? " "" "" ))
	(assert (mean-texture ?mt))
	(if (> ?mt 28.79)
		then (assert (breast-cancer 1))
	else (if (<= ?mt 28.79)
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