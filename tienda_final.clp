(deffacts bh
  (most pos 0 est1 pos 1 est2 pos 2 est3 pos 3 est4 pos 4 carro)
  (carro 0 50)
  (repuestos rep 40 0 rep 30 1 rep 20 2 rep 20 3))


(defrule meta
  (declare (salience 99))
  (repuestos rep 40 2 rep 30 0 rep 20 0 rep 20 0)
  =>
  (halt)
)

(defrule coger-repuesto
  ?f1 <- (carro ?lugar ?peso-max)
  ?f2 <- (repuestos $? rep ?p1 ?l1 $?)
  (test (and (= ?lugar ?l1) (<= ?p1 ?peso-max)))
  =>
  (assert (carro ?lugar (- ?peso-max ?p1)))
  (assert (repuestos $? rep ?p1 5 $?))
  (retract ?f1)
  (retract ?f2)
)

(defrule dejar-repuesto
  ?f1 <- (carro ?lugar ?peso-max)
  ?f2 <- (repuestos $? rep ?p1 ?l1 $?)
  (test (= ?l1 5))
  =>
  (assert (carro ?lugar (+ ?peso-max ?p1)))
  (assert (repuestos $? rep ?p1 ?lugar $?))
  (retract ?f1)
  (retract ?f2)
)

(defrule mover-hacia-est4
  ($?res1 ?id pos ?l $?res2)
  ?f <- (carro ?l1 ?p)
  (test (= (+ ?l1 1) ?l))
  =>
  (assert (carro ?l ?p))
  (retract ?f)
)

(defrule mover-hacia-most
  ($?res1 ?id pos ?l $?res2)
  ?f <- (carro ?l1 ?p)
  (test (= (- ?l1 1) ?l))
  =>
  (assert (carro ?l ?p))
  (retract ?f)
)
