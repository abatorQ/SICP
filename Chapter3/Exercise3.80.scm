; Exercise 3.80: A series RLC circuit consists of a resistor, a capacitor, and an inductor connected in series, as shown in Figure 3.36. If RR, LL, and CC are the resistance, inductance, and capacitance, then the relations between voltage (v)(v) and current (i)(i) for the three components are described by the equations
; vRvLiC===iRR,LdiLdt,CdvCdt,
; vR=iRR,vL=LdiLdt,iC=CdvCdt,
; and the circuit connections dictate the relations
; iRvC==iL=−iC,vL+vR.
; iR=iL=−iC,vC=vL+vR.
; Combining these equations shows that the state of the circuit (summarized by vCvC, the voltage across the capacitor, and iLiL, the current in the inductor) is described by the pair of differential equations
; dvCdtdiLdt==−iLC,1LvC−RLiL.
; dvCdt=−iLC,diLdt=1LvC−RLiL.
; The signal-flow diagram representing this system of differential equations is shown in Figure 3.37.

 
; Figure 3.37: A signal-flow diagram for the solution to a series RLC circuit.
; Write a procedure RLC that takes as arguments the parameters RR, LL, and CC of the circuit and the time increment dtdt. In a manner similar to that of the RC procedure of Exercise 3.73, RLC should produce a procedure that takes the initial values of the state variables, vC0vC0 and iL0iL0, and produces a pair (using cons) of the streams of states vCvC and iLiL. Using RLC, generate the pair of streams that models the behavior of a series RLC circuit with RR = 1 ohm, CC = 0.2 farad, LL = 1 henry, dtdt = 0.1 second, and initial values iL0iL0 = 0 amps and vC0vC0 = 10 volts.
 
(load "/home/soulomoon/git/SICP/Chapter3/stream.scm")

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream 
     initial-value
     (let ((integrand 
            (force delayed-integrand)))
       (add-streams 
        (scale-stream integrand dt)
        int))))
  int)


(define (RLC R C L dt)
  (define (iter vc0 il0)
      (define vc
        (delay (integral dvc vc0 dt)))
      (define iL
        (delay (integral diL il0 dt)))
      (define dvc
        (delay (scale-stream (force iL) (/ -1 C))))
      (define diL
        (delay (add-streams
                (scale-stream (force vc) (/ 1 L))
                (scale-stream (force iL) (* -1 (/ R L))))))
    (cons (force iL) (force vc)))
  iter)


(define RLC1 (RLC 1 0.2 1 0.1))

(define a (RLC1 10 0))
(display-10 (car a))
(display-10 (cdr a))

; Welcome to DrRacket, version 6.7 [3m].
; Language: SICP (PLaneT 1.18); memory limit: 128 MB.

; 0
; 1.0
; 1.9
; 2.66
; 3.249
; 3.6461
; 3.84104
; 3.834181
; 3.6359559
; 3.2658442599999997
; 2.750945989'done

; 10
; 10
; 9.5
; 8.55
; 7.220000000000001
; 5.5955
; 3.77245
; 1.8519299999999999
; -0.0651605000000004
; -1.8831384500000004
; -3.5160605800000004'done
; > 